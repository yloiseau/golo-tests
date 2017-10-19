#!/bin/bash

rm -rf build
mkdir -p build

javac -cp golo-3.3.0-SNAPSHOT.jar -d build ./*.java
golo compile --output build overloaded.golo

for i in $(seq "${1:-10}") ; do
    golo run --classpath build --module TestOverloaded
done | sort | uniq -c | sort -n
