## task1
- Convert encoding into more readable notation (R)ock, (P)aper, (S)cisors
- Create lookup table for score couting and compute score
```sh
tr 'ABCXYZ' 'RPSRPS' < in.txt |
awk 'BEGIN {
LUT["RR"]=4; LUT["PP"]=5; LUT["SS"]=6; # draws
LUT["SR"]=7; LUT["RP"]=8; LUT["PS"]=9; # wins
LUT["PR"]=1; LUT["SP"]=2; LUT["RS"]=3; # loses
} {points += LUT[$1 $2]}
END { print points }'
```
## task2
- Convert encoding into more readable notation (R)ock, (P)aper, (S)cisors, (L)ose, (D)raw, (W)in
- Create lookup table for score couting and compute score
```sh
tr 'ABCXYZ' 'RPSLDW' < in.txt |
awk 'BEGIN {
LUT["RD"]=4; LUT["PD"]=5; LUT["SD"]=6; # draws
LUT["SW"]=7; LUT["RW"]=8; LUT["PW"]=9; # wins
LUT["PL"]=1; LUT["SL"]=2; LUT["RL"]=3; # loses
} {points += LUT[$1 $2]}
END { print points }'
```
