
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
  
}
