#!/bin/sh
awk -v RS="\n\n" -F "\n" '{sum=0; for (i=1; i<=NF; ++i) sum += $i; print sum}' $1 | sort | tail -n1
