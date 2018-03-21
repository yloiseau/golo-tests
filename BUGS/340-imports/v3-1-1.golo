----
Import both modules, call with only module name.
----
module Test311

import plop.Foo
import plop.Bar

function main = |args| {
  require(Foo.polymorphic() == "Foo::polymorphic", "err Foo")
  require(Bar.polymorphic(42) == "Bar::polymorphic", "err Bar")
}
