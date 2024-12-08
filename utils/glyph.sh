#!/usr/bash

cp="$(echo -n "$1" | python -c "import sys;  print(f'{ord(sys.stdin.readline()):x}')")"

fc-list ":charset=$cp" | awk -F: '{print $2}' | sort | uniq | awk '{sub(/\s+/,""); printf "%-3d %s\n",NR,$0}'

eval "c=$'\U$cp'"
echo -e "\ncontaining glyph: $c (U+${cp})"

# this is not reliable
# font=$(FC_DEBUG=4 pango-view --font=monospace -t $c -q 2>&1 | grep family: | tail -n1 | awk 'match($0,/^\s*(family:)\s*"(.*)".*$/,m) {print m[2]}')
# echo "rendered with (best guess): $font"

# uncomment this to show what font is used to render the glyph
# FC_DEBUG=4 pango-view --font=monospace -t $c -q | grep family:
