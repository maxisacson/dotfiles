#!/usr/bash

fc-list ":charset=$1" | awk -F: '{print $2}' | sort | uniq | awk '{sub(/\s+/,""); printf "%-3d %s\n",NR,$0}'
echo -e "\ncontaining glyph: \U$1"
