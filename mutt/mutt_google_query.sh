#!/bin/sh
# Shamelessly stolen from http://onepeople.org/node/2063
goobook query "$*" | sed -e '/^$/d' -e 's/\(.*\) \(.*\)\t.*/\1 \2/' -e 's/\(^\<.*\)\t\(.*\)/"\2" \<\1\>/'
