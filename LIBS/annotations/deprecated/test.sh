#!/bin/bash

# export GOLO_OPTS="-Dgolo.debug=true"

echo "== On function"
golo compile test.golo && javac -Xlint:deprecation Main.java && golo golo --files main.golo

echo ""
echo "== On struct"
golo compile testStruct.golo && javac -Xlint:deprecation TestStruct.java && golo golo --files testStruct.golo

echo ""
echo "== On module"
golo compile mod.golo
javac -Xlint:deprecation TestMod.java
golo golo --files testmod.golo


echo ""
echo "== On multiple"
golo compile multi.golo
javac -Xlint:deprecation TestMulti.java
golo golo --files testmulti.golo
