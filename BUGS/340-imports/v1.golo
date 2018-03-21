
module test1

import plop

function main = |args| {
  require(Foo.doit() == "Foo::doit", "err: " + Foo.doit())
  require(Bar.doit() == "Bar::doit", "err: " + Bar.doit())
}
