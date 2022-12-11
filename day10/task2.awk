#!/usr/bin/awk -f
BEGIN{REG=1;CYCLE=1}
function wait(n) {
    for(i=1;i<=n;++i) {
        if(COL>39) { COL=0; printf "\n" };
        if(COL==REG-1 || COL==REG || COL==REG+1) printf "#"
        else printf "."
        CYCLE++; COL++;
    }
}
/addx/ { wait(2); REG+=$2 }
/noop/ { wait(1); }
