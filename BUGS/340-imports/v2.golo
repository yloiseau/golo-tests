
module test2a

import plop.Foo
import plop.Bar

function main = |args| {
  require(doit() == "Foo::doit", "err")
}
