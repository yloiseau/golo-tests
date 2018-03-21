
module test2a

import plop.Bar
import plop.Foo

function main = |args| {
  require(doit() == "Bar::doit", "err")
}
