
module test2c

import plop.Foo
import plop.Bar

function main = |args| {
  require(plop.Foo.doit() == "Foo::doit", "err")
  require(plop.Bar.doit() == "Bar::doit", "err")
}
