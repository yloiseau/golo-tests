module Tool

import gololang.ir.DSL
import gololang.ir.Quote



macro wrapAnnotation = |annotationClass, isVisible| {
  let macroName = annotationClass: value(): getSimpleName()
  return `macro(macroName): withParameters("args"): varargs(): body(&quote {
    let p, n, e = gololang.macros.Utils.parseArguments($args, true)
    gololang.Meta.addAnnotation($(annotationClass), $(isVisible), n, e)
    return e
  })
}

macro simpleAnnotationWrapper = |annotationClassReference| -> generateWrapper(
  annotationClassReference: value(): getName(): split("\\."): last(),
  annotationClassReference)

macro namedAnnotationWrapper = |name, annotationClassReference| -> generateWrapper(
  name: value(),
  annotationClassReference)

local function generateWrapper = |macroName, annotationClassReference| -> `macro(macroName)
  : withParameters("elts"): varargs(): body(&quote {
    return Tool.annotateElements($elts, $(annotationClassReference), null)
  })

function annotateElements = |elts, annotationClass, args| -> Tool.annotateElement(
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
function isApplicableTo = |annotationClass, target| {
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

function extractAnnotationFields =|annotationClass| {
  return array[
    [
      meth: getName(), 
      org.eclipse.golo.runtime.TypeMatching.boxed(meth: getReturnType()),
      meth: getDefaultValue() isnt null
    ] foreach meth in annotationClass: getDeclaredMethods()
  ]
}

function getAnnotationValue = |macroArgument| -> match {
  when macroArgument oftype gololang.ir.ConstantStatement.class and macroArgument: value() oftype
  gololang.ir.ClassReference.class then macroArgument: value(): dereference()
  when macroArgument oftype gololang.ir.ConstantStatement.class then macroArgument: value()
  otherwise macroArgument
}
