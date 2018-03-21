
module test0

function main = |args| {
  require(plop.Foo.doit() == "Foo::doit", "err")
  require(plop.Bar.doit() == "Bar::doit", "err")
}
