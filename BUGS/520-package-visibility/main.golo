module Main

import net.yloiseau.tools

function main = |args| {
  println("# Call a package static method")
  print("> ")
  println(Main.callFun())

  # println("# Call a package constructor")
  # print("> ")
  # println(Main.createA(42): answer())

  println("# Call a package instance method")
  print("> ")
  println(Main.callMeth())
}
