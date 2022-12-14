This day solutions are in C++

The task2 solution only prints sorted packet list (after inserting dividers),
so its output needs to be postprocessed to extract exact solution:
```sh
c++ task2.cpp -o task2
./task2 <in.txt | awk 'BEGIN{mult=1} $0=="[[[2]]]" || $0=="[[[6]]]" {mult*=NR} END{print mult}'
```
