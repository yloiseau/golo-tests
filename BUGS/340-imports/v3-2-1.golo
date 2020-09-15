----
import only common package, call with module
----
module Test321

import plop

function main = |args| {
  let f = Foo.polymorphic()
  let b = Bar.polymorphic(42)
  require(f == "Foo::polymorphic", "err Foo: " + f)
  require(b == "Bar::polymorphic", "err Bar: " + b)
}
