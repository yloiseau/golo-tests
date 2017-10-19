#!/bin/bash

rm -rf build
mkdir -p build

javac -d build ./*.java
golo compile --output build ./*.golo

for i in $(seq "${1:-10}") ; do
    golo run --classpath build --module TestOverloaded
done | sort | uniq -c | sort -n
