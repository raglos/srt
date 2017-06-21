#!/bin/bash
# srt.sh
# requires 'cat', 'egrep', 'tr', 'awk', 'sed'.
# you should have this installed.

if [[ -z "$1" || -z "$2" ]]; then
    echo "usage: ""$0"" <FILE> <TIME DIFF>";
    echo "eg '  ""$0"" movie.srt 3500 '  prints the srt-file with";
    echo "a 3.5 second delay. To reduce delay, use a negative number.";
    exit 1;
fi


FILE=$(cat "$1")
DIFF="$2";
SRT=$(echo "$FILE" | tr '\r\n' '$' | sed 's/\$\$/\%\%/g'        \
| grep -Eo '[0-9]+\$[0-9\:\,]+\s*-->\s*[0-9\:\,]+\$[^\%]+\%\%' \
| sed 's/\$/\::::::/g')


echo "$SRT" | awk -v _DIFF="$DIFF" -f srt.awk \
| sed 's,\(.*\)\%\%$,\1,g'

