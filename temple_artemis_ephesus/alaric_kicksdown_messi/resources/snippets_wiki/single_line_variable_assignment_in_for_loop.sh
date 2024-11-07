#!/bin/bash
# -- DESC: bash single line variable assignment and function call within for loop

for elm in "${arr[@]}"; do x=$(echo "$elm" | tr -d '"'); myfunc "$x"; done
