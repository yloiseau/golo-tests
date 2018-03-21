
module test1

import plop

function main = |args| {
  require(Foo.doit() == "Foo::doit", "err")
  require(Bar.doit() == "Bar::doit", "err")
}
