#!/usr/bin/awk -f
BEGIN{REG=1;CYCLE=1}
function wait(n) {
    for(i=1;i<=n;++i) {
        if((CYCLE-20) % 40 == 0) { SIGNAL_SUM += CYCLE*REG };
        CYCLE++;
    }
}
/addx/ { wait(2); REG+=$2 }
/noop/ { wait(1); }
END { print SIGNAL_SUM }
