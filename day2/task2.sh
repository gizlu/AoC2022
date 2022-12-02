#!/bin/sh
tr 'ABCXYZ' 'RPSLDW' <$1 | # convert input to more readable notation: (R)ock, (P)aper, (S)cisors, (L)ose, (D)raw, (W)in
awk 'BEGIN {
LUT["RD"]=4; LUT["PD"]=5; LUT["SD"]=6; # draws
LUT["SW"]=7; LUT["RW"]=8; LUT["PW"]=9; # wins
LUT["PL"]=1; LUT["SL"]=2; LUT["RL"]=3; # loses
} {points += LUT[$1 $2]}
END { print points }'
