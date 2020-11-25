#!/bin/bash
# using GNU Sed
FILE=${FILENAME}
cat $FILE | gsed -E 's/([[:lower:]])([[:upper:]])/\1\n\2/g' > $filename.txt
