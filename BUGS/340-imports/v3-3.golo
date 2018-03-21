----
no import, call FQN
----
module Test33

function main = |args| {
  require(plop.Foo.polymorphic() == "Foo::polymorphic", "err Foo")
  require(plop.Bar.polymorphic(42) == "Bar::polymorphic", "err Bar")
}
