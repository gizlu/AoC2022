## task1
- build lookup table for priorities
- for each line find item present in both compartments and add its piority to sum

```awk
awk -F '' '
BEGIN{ for(i=0; i<26;i++) LUT[sprintf("%c",i+97)]=i+1; } # a-z (97 - "a" ascii code)
BEGIN{ for(i=0; i<26;i++) LUT[sprintf("%c",i+65)]=i+27; } # A-Z (65 - "A" ascii code)
{ for(i=1; i<=NF/2; ++i)
   for(j=NF/2+1; j<=NF; ++j) if($i==$j) { s+=LUT[$i]; next }
} END { print s }' in.txt
```

## task2
- join every group of 3 lines into one line
- build lookup table for priorities
- for each group find item present in all 3 rucksacks and add its piority to sum
```awk
xargs -n3 <in.txt | awk '
BEGIN{ for(i=0; i<26;i++) LUT[sprintf("%c",i+97)]=i+1; } # a-z (97 - "a" ascii code)
BEGIN{ for(i=0; i<26;i++) LUT[sprintf("%c",i+65)]=i+27; } # A-Z (65 - "A" ascii code)
{ for(ch in LUT) if($1 ~ ch && $2 ~ ch && $3 ~ ch) { s+=LUT[ch]; next } }
END { print s }'
```
