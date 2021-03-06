#!/bin/bash

rm -rf build
mkdir -p build

javac -cp golo-3.3.0-SNAPSHOT.jar -d build ./*.java

for i in $(seq "${1:-10}") ; do
    golo golo --classpath build --files overloaded.golo
done | sort | uniq -c | sort -n
