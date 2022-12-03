## task1
Create sorted list of summaric caloricity of each each elf inventory and extract "the richest elf"
```awk
awk -vRS="\n\n" -F"\n" '{s=0; for(i=1; i<=NF; ++i) s+=$i; print s}' in.txt | sort | tail -n1
```

## task2
Create sorted list of summaric caloricity of each each elf inventory and compute sum of "three richest elfs"
```awk
awk -vRS="\n\n" -F"\n" '{s=0; for(i=1; i<=NF; ++i) s+=$i; print s}' in.txt | sort | tail -n3 | awk '{s+=$1}END{print s}'
```
