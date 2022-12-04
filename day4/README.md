## task1
- count how many lines have one range fully conaining the other
```awk
awk -F'[-,]' '{if (($1>=$3 && $2<=$4) || (($3>=$1) && ($4<=$2))) ++s} END{print s}' in.txt
```

## task2
- count how many lines have overlaping ranges
```awk
awk -F'[-,]' '{if (($3>=$1 && $3<=$2) || ($1>=$3 && $1<=$4)) ++s} END{print s}' in.txt
```

