#!/bin/bash

for f in v*.golo; do
    echo -n "$f (without package module): "
    golo golo --files foo.golo bar.golo $f 2>/dev/null && echo -e "\033[32mOK\033[0m" || echo -e "\033[31mFAILED\033[0m"

    echo -n "$f (with package module): "
    golo golo --files plop.golo foo.golo bar.golo $f 2>/dev/null && echo -e "\033[32mOK\033[0m" || echo -e "\033[31mFAILED\033[0m"
done
