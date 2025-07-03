#!/usr/bin/env bash

fd -Htf '^.git$' ~/dev -x grep -lv '\./\.bare' {} \; | while read -r line; do gsed -i 's/gitdir: \/Users\/caccola\/dev\/\(.*\)/gitdir: \/Users\/caccola\/Development\/\1/' $line; done

fd -Htd '.bare' -x grep -rl '/Users/caccola/dev' {} \; | while read -r line; do gsed -i 's!/Users/caccola/dev/!/Users/caccola/Development/!' $line; done
