
module TestAnnotations

import annotations

function test_on_method = {
  require(Annotate.class: getDeclaredMethod("plop"): isAnnotationPresent(OnMethod.class),
          "No OnMethod Annotation")
}

function test_on_module = {
  require(Annotate.class: isAnnotationPresent(OnClass.class),
            "No OnClass on the module itself")
}

function test_on_struct = {
  require(Annotate.types.Foo.class: isAnnotationPresent(OnClass.class),
            "No OnClass on the struct")
}

function test_on_union_abstract = {
  require(Annotate.types.Egg.class: isAnnotationPresent(OnClass.class),
            "No OnClass on the union")
  require(not Annotate.types.Egg$Spam.class: isAnnotationPresent(OnClass.class),
            "OnClass on the union value")
  require(Annotate.types.Bar$A.class: isAnnotationPresent(OnClass.class),
            "No OnClass on the union")

}

function test_on_union_inherit = {
  require(Annotate.types.Bar.class: isAnnotationPresent(OnClassInherit.class),
            "No OnClassInherit on the union")
  require(Annotate.types.Bar$A.class: isAnnotationPresent(OnClassInherit.class),
            "No OnClassInherit on the union A")
  require(Annotate.types.Bar$B.class: isAnnotationPresent(OnClassInherit.class),
            "No OnClassInherit on the union B")
}

function test_on_augmentation = {
  require(Annotate$Aaa.class: isAnnotationPresent(OnClass.class),
          "No OnClass on the named augmentation")
  require(Annotate$java$lang$String.class: isAnnotationPresent(OnClass.class),
          "No OnClass on the augmentation")
}

function test_on_both = {
  require(Annotate.types.Both.class: isAnnotationPresent(OnBoth.class),
          "No OnBoth on type")
  require(Annotate.class: getDeclaredMethod("both"): isAnnotationPresent(OnBoth.class),
          "No OnBoth on function")
}

function test_on_all = {
  require(Annotate.types.All.class: isAnnotationPresent(OnAll.class),
          "No OnAll on type")
  require(Annotate.class: getDeclaredMethod("all"): isAnnotationPresent(OnAll.class),
          "No OnAll on function")
}

function test_on_multiple = {
  require(Annotate.types.Multi.class: isAnnotationPresent(OnAll.class),
          "No OnMultiple complex on type")
  require(Annotate.types.Multi2.class: isAnnotationPresent(OnAll.class),
          "No OnMultiple simple on type")
  require(Annotate.class: getDeclaredMethod("multi1"): isAnnotationPresent(OnAll.class),
          "No OnMultiple complex on function 1")
  require(Annotate.class: getDeclaredMethod("multi2"): isAnnotationPresent(OnAll.class),
          "No OnMultiple complex on function 2")
  require(Annotate.class: getDeclaredMethod("multi3"): isAnnotationPresent(OnAll.class),
          "No OnMultiple simple on function 3")
}

function test_stack = {
  let f1 = Annotate.class: getDeclaredMethod("stack1")
  let f2 = Annotate.class: getDeclaredMethod("stack2")
  let f3 = Annotate.class: getDeclaredMethod("stack3")
  let f4 = Annotate.class: getDeclaredMethod("stack4")
  let f5 = Annotate.class: getDeclaredMethod("stack5")
  require(f1: isAnnotationPresent(OnMethod.class)
      and f1: isAnnotationPresent(OnBoth.class),
          "simple stack failed on 1st function")
  require(f2: isAnnotationPresent(OnMethod.class)
      and f2: isAnnotationPresent(OnAll.class),
          "simple stack failed on 2nd function")
  require(f3: isAnnotationPresent(OnMethod.class)
      and f3: isAnnotationPresent(OnAll.class),
          "simple stack failed on 3rd function")
  require(f4: isAnnotationPresent(OnMethod.class)
      and f4: isAnnotationPresent(OnAll.class),
          "simple stack failed on 4th function")
  require(f5: isAnnotationPresent(OnMethod.class)
      and f5: isAnnotationPresent(OnBoth.class),
          "simple stack failed on 5th function")
}

function test_simple_value = {
  let a = Annotate.class: getDeclaredMethod("withInt"): getAnnotation(WithIntArg.class)
  require(a isnt null, "No WithInt annotation")
  require(a: val() == 42, "Bad withint value")
}

function main = |args| {
  test_on_method()
  test_on_module()
  test_on_struct()
  test_on_union_abstract()
  test_on_union_inherit()
  test_on_augmentation()
  test_on_both()
  test_on_all()
  test_stack()
  test_simple_value()
  println("ok")
}
