----
import both modules, call FQN
----
module Test312

import plop.Foo
import plop.Bar

function main = |args| {
  require(plop.Foo.polymorphic() == "Foo::polymorphic", "err Foo")
  require(plop.Bar.polymorphic(42) == "Bar::polymorphic", "err Bar")
}
