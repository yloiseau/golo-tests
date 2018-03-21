----
import only common package, call with module
----
module Test321

import plop

function main = |args| {
  require(Foo.polymorphic() == "Foo::polymorphic", "err Foo")
  require(Bar.polymorphic(42) == "Bar::polymorphic", "err Bar")
}
