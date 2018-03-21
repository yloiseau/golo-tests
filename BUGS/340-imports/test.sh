#!/bin/bash

if [[ "$1" == "-v" ]] ; then
    export GOLO_OPTS="-Dgolo.debug.function-resolution=true"
    out=/dev/fd/1
else
    out=/dev/null
fi

for f in v*.golo; do
    echo -n "$f (without package module): "
    golo golo --files foo.golo bar.golo $f 2> $out && echo -e "\033[32mOK\033[0m" || echo -e "\033[31mFAILED\033[0m"

    echo -n "$f (with package module): "
    golo golo --files plop.golo foo.golo bar.golo $f 2> $out && echo -e "\033[32mOK\033[0m" || echo -e "\033[31mFAILED\033[0m"
done
