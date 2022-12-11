#!/bin/sh
awk -F '' '{for(i=1;i<=NF;++i) print $i" "$(i+1)" "$(i+2)" "$(i+3)}' <in.txt |
awk '$1!=$2 && $1!=$3 && $1!=$4 && $2!=$3 && $2!=$4 && $3!=$4 {print NR+3; exit}'
