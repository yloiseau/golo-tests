module net.yloiseau.tools.Main

function createA = |v| -> net.yloiseau.tools.A(v)

function callFun = -> net.yloiseau.tools.A.fun()

function callMeth = -> net.yloiseau.tools.A.of(42): meth()
