
module AnnotationMacros

import gololang.ir

import Tool

# local function parseAnnotationArguments = |args| {
#   let p, n, e = gololang.macros.Utils.parseArguments(args, true)
#   let annotArgs = map[]
#   foreach k, v in n {
#     if v oftype ConstantStatement.class {
#       annotArgs: put(k, v: value())
#     }
#   }
#   return [annotArgs, e]
# }

&simpleAnnotationWrapper(annotations.OnMethod.class)
&simpleAnnotationWrapper(annotations.OnClass.class)
&simpleAnnotationWrapper(annotations.OnClassInherit.class)
&simpleAnnotationWrapper(annotations.OnBoth.class)
&simpleAnnotationWrapper(annotations.OnAll.class)
&namedAnnotationWrapper("OnMultiple", annotations.OnAll.class)

macro WithIntArg = |val, elts...| {
  if not (val: value() oftype java.lang.Integer.class) {
    throw java.lang.annotation.AnnotationTypeMiscmatchException()
  }
  return Tool.annotateElements(elts,
            annotations.WithIntArg.class,
            map[["val", val: value()]])
}

macro WithNamedArg = |args...| {
  let p, n = gololang.macros.Utils.parseArguments(args)
  let annotationFields = map[]
  foreach name, type, hasDefault in extractAnnotationFields(annotations.WithNamedArg.class) {
    let value = Tool.getAnnotationValue(n: get(name))
    require(value oftype type or (hasDefault and value is null), 
        "Bad value for `%s`. Got %s but need a %s": format(name, value, type: name()))
    if (value isnt null) {
      annotationFields: put(name, value)
    }
  }
  return Tool.annotateElements(p,
            annotations.WithNamedArg.class,
            annotationFields)
}

macro test = |arg| {
  println(arg: getClass())
}
