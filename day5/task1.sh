#!/bin/sh
sed 's/    / 0 /g' <in.txt | tr -d '[]' | awk --lint '
NR==1 { stacks=NF; for(i=1; i<=NF; ++i) heads[i]=1; }
$1!=1 && $1!="move" { for(i = 1; i<=NF; ++i) { if($i==0) {heads[i]++} else ARR[i,NR]=$i } }
$1=="move" { for(i=1; i<=$2; ++i) ARR[$6,--heads[$6]] = ARR[$4,heads[$4]++] }
END { for(i=1; i<=stacks; ++i) printf "%c",ARR[i,heads[i]] }'
