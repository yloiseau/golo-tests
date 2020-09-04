
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
  return Tool.annotateElement(match {
      when isArray(elts) and elts: size() == 1 then elts: get(0)
      when isArray(elts) then gololang.ir.ToplevelElements.of(elts)
      otherwise elts
    }, annotations.WithIntArg.class, map[["val", val: value()]])
}
