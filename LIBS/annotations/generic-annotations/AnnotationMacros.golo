
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
  foreach name, type, hasDefault in array[["a", Integer.class, false], ["b", String.class, true]] {
    let value = Tool.getAnnotationValue(n: get(name))
    require(value oftype type or (hasDefault and value is null), 
        "Bad value")
    # for `%s`. %s expected, got a %s (%s).": format(
    #         name, 
    #         type: getName(),
    #         value?: getClass()?: getName() orIfNull "null value",
    #         value))
    if (value isnt null) {
      annotationFields: put(name, value)
    }
  }
  println("## " + annotationFields)
  return Tool.annotateElements(p,
            annotations.WithNamedArg.class,
            annotationFields)
}

macro test = |arg| {
  println(arg: getClass())
}
