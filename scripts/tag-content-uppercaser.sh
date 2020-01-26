#!/bin/bash

# Usage: ./tag-content-uppercaser.sh <FILE> <TAG>
#
# Example: ./tag-content-uppercaser.sh file.html em
#         <em> content </em>  -----> <em> CONTENT </em>

sed -r -i -E "s/(<$2.*>)(.*.)(<\/$2>)/\1\U\2\L\3/" $1
