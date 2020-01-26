#!/bin/bash

# Simple html tag remover

# Usage:
#        cat file.html | ./tag-remover.sh <FILE> <HTML-TAG-TO-REMOVE>
# Example:
#        cat file.html | ./tag-remover.sh file.html "em"
# Bugs:
#        Won't work with complex tags; eg if tag content has linebreaks inside

sed -r -i -E "s/(<$2.*>)(.*.)(<\/$2>)/\2/" $1
