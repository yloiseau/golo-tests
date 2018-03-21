
module test2b

import plop.Foo
import plop.Bar

function main = |args| {
  require(Foo.doit() == "Foo::doit", "err Foo")
  require(Bar.doit() == "Bar::doit", "err Bar")
}
