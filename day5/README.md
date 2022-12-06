[This day I have done task1 also in C](task1.c)
## shell/awk solutions
### task1
- Fill empty stack blocks with zeros and remove annoying brackets
- Fill stacks like normal 2d array
- After filling stacks we abuse dict-like nature of awk arrs, and make our
  stacks "grow down" (yes, we use negative indexes)
- Read and execute move commands, by moving each package separatly (resulting stack fragment is reversed original)
- Finally, print top of each stack
```awk
sed 's/    / 0 /g' <in.txt | tr -d '[]' | awk '
NR==1 { stacks=NF; for(i=1; i<=NF; ++i) heads[i]=1; }
$1!=1 && $1!="move" { for(i = 1; i<=NF; ++i) { if($i==0) {heads[i]++} else ARR[i,NR]=$i } }
$1=="move" { for(i=1; i<=$2; ++i) ARR[$6,--heads[$6]] = ARR[$4,heads[$4]++] }
END { for(i=1; i<=stacks; ++i) printf "%c",ARR[i,heads[i]] }'
```
### task2
Like task1 but with slightly modified `move` command behaviour:

if multiple packages are moved using single invokation, they are relocated as is (resulting stack fragment is ordered like orginal)

```awk
sed 's/    / 0 /g' <in.txt | tr -d '[]' | awk '
NR==1 { stacks=NF; for(i=1; i<=NF; ++i) heads[i]=1; }
$1!=1 && $1!="move" { for(i = 1; i<=NF; ++i) { if($i==0) {heads[i]++} else ARR[i,NR]=$i } }
$1=="move" { for(i=$2; i>=1; --i) ARR[$6,heads[$6]-i] = ARR[$4,heads[$4]++]; heads[$6]-=$2; }
END { for(i=1; i<=stacks; ++i) printf "%c",ARR[i,heads[i]] }'
```
