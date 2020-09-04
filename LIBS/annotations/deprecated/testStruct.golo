
module TestForStruct

@deprecated
struct Foo = {x}

function main = |args| {
  let f = Foo(42)
}
