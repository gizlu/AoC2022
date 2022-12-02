#!/bin/sh
tr 'ABCXYZ' 'RPSRPS' <$1 | # convert input to more readable notation: (R)ock, (P)aper, (S)cisors
awk 'BEGIN {
LUT["RR"]=4; LUT["PP"]=5; LUT["SS"]=6; # draws
LUT["SR"]=7; LUT["RP"]=8; LUT["PS"]=9; # wins
LUT["PR"]=1; LUT["SP"]=2; LUT["RS"]=3; # loses
} {points += LUT[$1 $2]}
END { print points }'
