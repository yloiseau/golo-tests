
module TestOverloaded

import test

local function test = |v, e| {
  if not v: startsWith(e) {
    println("Should be %s but is %s": format(e, v))
  }
}

function main = |args| {
  let t = OverloadedMethod()

  test(t: foo("a"), "String")
  
  # should be Integer and not Number since we want to use the most specific
  # method
  # test(t: foo(1), "Integer")
  
  test(t: foo(2.5), "Number")
  
  test(t: foo(Wrapper.of("w")), "Wrapper")
}
