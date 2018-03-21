
----
import only common package, call FQN
----
module Test322

import plop

function main = |args| {
  require(plop.Foo.polymorphic() == "Foo::polymorphic", "err Foo")
  require(plop.Bar.polymorphic(42) == "Bar::polymorphic", "err Bar")
}
