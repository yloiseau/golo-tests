
----
import both modules, call with only function name
----
module Test313

import plop.Foo
import plop.Bar

function main = |args| {
  require(polymorphic(42) == "Bar::polymorphic", "err Bar")
  require(polymorphic() == "Foo::polymorphic", "err Foo")
}
