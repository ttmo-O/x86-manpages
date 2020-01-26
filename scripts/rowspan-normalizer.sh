#!/bin/bash

# Simple rowspan normalizer
#
#        before                        after
#  +--------+--------+          +--------+--------+
#  |  asd   |  fsdaf |          |  asd   |  fsdaf |
#  +        +--------+   --->   +--------+--------+
#  |        | asdffsa|          |        | asdffsa|
#  +--------+--------+          +--------+--------+
#
# Usage: ./rowspan-normalizer.sh bla.html
#
# Requirements: GNU sed
#               Roughly beautified html as input
#
# Thanks to all rondom internet guys for random helps on sed and the others

FILE=$1
CTR=0

# ehe, i hope you don't use rowspan word in your body text
while (grep "td rowspan" $FILE) ; do
        # get rowspan value encountered first; and it's line number
        ROWSPANVAL=$(grep "rowspan" $FILE | grep -o '[0-9]\+' | head -n 1)
        ROWSPANLINENR=$(grep -n "rowspan" $FILE | grep -o '[0-9]\+' | head -n 1)

        # split file into two from "rowspan" keyword
        head -n $(($ROWSPANLINENR - 1)) $FILE > "$FILE.head"
        tail --lines=+$ROWSPANLINENR $FILE > "$FILE.tail"

        # place an empty row for each "spanned" row - 1 (itself)
        for i in $(seq $(($ROWSPANVAL-1)) -1 1); do
                sed -z -i "s/<tr>/<tr>\n<td><\/td>/$i" $FILE.tail
        done

        # remove the FIRST "rowspan" keyword
        # by sed magic that you'll forget how it was working after 30 seconds
        # you wrote it
        sed -r -i -E "1s/(<td rowspan.*)(.*>)(.*.)(<\/td>)/<td>\3<\/td>/" $FILE.tail

        # write back to file
        cat "$FILE.head" "$FILE.tail" > $FILE

        # remove artifacts
        rm $FILE.head $FILE.tail
        CTR=$(($CTR + 1))

        # break infinite loop heuristically
        if [ "$CTR" -gt "300" ]; then
                echo "Deadlock break"
                break
        fi
done

echo "Normalized $CTR rowspans. See you tomorrow."
