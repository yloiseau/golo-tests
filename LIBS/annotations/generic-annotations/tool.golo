module Tool

import gololang.ir.DSL
import gololang.ir.Quote

&use("gololang.macros.Utils")


macro annotationWrapper = |annotationClassReference| -> generateWrapper(
  annotationClassReference: value(): getName(): split("\\."): last(),
  annotationClassReference)

macro annotationWrapper = |annotationClassReference, name| -> generateWrapper(
  name: value(),
  annotationClassReference)


function applyAnnotation = |annotationClass, arguments| {
  let a, e = extractAnnotationArguments(annotationClass, arguments)
  return annotateElements(e, annotationClass, a)
}

local function generateWrapper = |macroName, annotationClassReference| -> `macro(macroName)
  : withParameters("args"): varargs(): body(`return(call(&thisModule("applyAnnotation")): withArgs(
    annotationClassReference, refLookup("args"))))

function annotateElements = |elts, annotationClass, args| -> annotateElement(
  match {
      when isArray(elts) and elts: size() == 1 then elts: get(0)
      when isArray(elts) then gololang.ir.ToplevelElements.of(elts)
      otherwise elts
  }, annotationClass, args)

local function annotateElement = |elt, annotationClass, args| {
  if elt oftype gololang.ir.ToplevelElements.class {
    foreach e in elt {
      annotateElement(e, annotationClass, args)
    }
  } else { 
    checkApplicableTo(annotationClass, elt)
    gololang.Meta.addAnnotation(annotationClass, args, elt)
  }
  return elt
}

# TODO: mapping for other types: fields, variables
local function isApplicableTo = |annotationClass, target| {
  let annotationTargets = annotationClass: getAnnotation(java.lang.annotation.Target.class)?: value()
  let targetType = match {
    when target oftype gololang.ir.GoloFunction.class then java.lang.annotation.ElementType.METHOD()
    when target oftype gololang.ir.GoloType.class then java.lang.annotation.ElementType.TYPE()
    when target oftype gololang.ir.GoloModule.class then java.lang.annotation.ElementType.TYPE()
    when target oftype gololang.ir.NamedAugmentation.class then java.lang.annotation.ElementType.TYPE()
    when target oftype gololang.ir.Augmentation.class and target: hasFunctions() then java.lang.annotation.ElementType.TYPE()
    otherwise null
  }
  return annotationTargets is null 
         or (targetType isnt null
             and java.util.Arrays.asList(annotationTargets): contains(targetType))
}

function checkApplicableTo = |annotationClass, target| {
  require(isApplicableTo(annotationClass, target),
          "Annotation %s not applicable on a %s": format(annotationClass: getName(), target: getClass(): getName()))
}

local function extractAnnotationFields =|annotationClass| {
  return array[
    [
      meth: getName(), 
      org.eclipse.golo.runtime.TypeMatching.boxed(meth: getReturnType()),
      meth: getDefaultValue() isnt null
    ] foreach meth in annotationClass: getDeclaredMethods()
  ]
}

local function extractAnnotationNamedArguments = |annotClass, namedArgs| {
  let annotationFields = map[]
  foreach field in extractAnnotationFields(annotClass) {
    fillArgumentsMap(annotationFields, field, getAnnotationValue(namedArgs: get(field: get(0))))
  }
  return annotationFields
}

local function filterPositionnalArguments = |args| {
  let arguments = vector[]
  let elements = vector[]
  foreach arg in args {
    let value = getAnnotationValue(arg)
    if value is null {
      continue
    }
    if value oftype gololang.ir.GoloElement.class {
      elements: add(value)
    } else {
      arguments: add(value)
    }
  }
  require(not (elements: isEmpty()), "No element to annotate")
  return [arguments, elements: toArray()]
}

local function fillArgumentsMap = |map, field, value| {
  let name, type, hasDefault = field
  if (value isnt null) {
    map: put(name, value)
  }
}

function extractAnnotationArguments = |annotationClass, args| {
  let p, n = gololang.macros.Utils.parseArguments(args)
  let namedMap = extractAnnotationNamedArguments(annotationClass, n)
  let positionnals, elements = filterPositionnalArguments(p)
  let fields = extractAnnotationFields(annotationClass)
  require(not (fields: isEmpty())
          or (namedMap: isEmpty() and positionnals: isEmpty()),
      "The annotation %s has no field": format(annotationClass: name()))
  require(fields: size() <= 1 or positionnals: isEmpty(), 
      "The annotation %s has several fields. Use the named arguments syntax": format(annotationClass: name()))
  require((fields: size() != 1 or fields: get(0): get(2)) or not (namedMap: isEmpty()) or not (positionnals: isEmpty()),
      "The annotation %s has 1 field with no default and no argument was provided": format(annotationClass: name()))

  if fields: size() == 1 and namedMap: isEmpty() and not (positionnals: isEmpty()) {
    fillArgumentsMap(namedMap, fields: get(0), positionnals: get(0))
  }
  return [namedMap, elements]
}

function getAnnotationValue = |macroArgument| -> match {
  when macroArgument oftype gololang.ir.ConstantStatement.class and macroArgument: value() oftype
    gololang.ir.ClassReference.class then macroArgument: value(): dereference()
  when macroArgument oftype gololang.ir.ConstantStatement.class then macroArgument: value()
  when macroArgument oftype gololang.ir.CollectionLiteral.class then array[getAnnotationValue(e) foreach e in macroArgument: children()]
  when isEnum(macroArgument) then loadEnum(macroArgument: packageAndClass())
  otherwise macroArgument
}

local function isEnum = |arg| -> arg oftype gololang.ir.FunctionInvocation.class 
                                and arg: arity() == 0
                                and Class.forName(arg: packageAndClass(): packageName()): isEnum()

local function loadEnum = |name| -> java.lang.Enum.valueOf(Class.forName(name: packageName()), name: className())
