
@OnClass
module Annotate

&use("AnnotationMacros")

@OnMethod
function plop = -> null


@OnClass
struct Foo = {x}

@OnClassInherit
union Bar = {
  @OnClass
  A
  B = {a,b}
}

@OnClass
union Egg = {
  Spam
}

@OnClass
augmentation Aaa = {
  function spam =  |this| -> null
}

@OnClass
augment java.lang.String {
  function foo = |this| -> 42
}

@OnBoth
function both = -> null

@OnBoth
struct Both = {on}

@OnAll
function all = -> null

@OnAll
struct All = {on}

&OnMultiple {
function multi1 = -> null
function multi2 = -> null
struct Multi = {on}
}

@OnMultiple
function multi3 = -> null

@OnMultiple
struct Multi2 = {on}

&OnMethod {

@OnBoth
function stack1 = -> null

@OnAll
function stack2 = -> null

}

&OnMethod {
&OnAll {
function stack3 = -> null
function stack4 = -> null
}
}

@OnMethod
@OnBoth
function stack5 = -> null

@WithIntArg(42)
function withInt = -> null

&WithIntArg(12) {
  function withIntA = -> null
  function withIntB = -> null
}

@WithNamedArg(a=42, b="hello", c=java.lang.String.class)
function intStringA = -> null

@WithNamedArg(a=42)
function intStringB = -> null

&WithNamedArg(a=42, b="hello") {
function intStringC1 = -> null
function intStringC2 = -> null
}

