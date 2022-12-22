#!/usr/bin/awk -f
# Equation builder. You can pipe its output to something like `qalc`
BEGIN {FS="(: )|( )" }
NF==2 { VAL[$1]=$2 }
NF==4 { LEFT[$1]=$2; OP[$1]=$3; RIGHT[$1]=$4 }

function makexpr(monke) {
    if(monke == "humn") printf "x"
    else if(monke in LEFT) {
        printf "("; makexpr(LEFT[monke]);
        printf "%c",  OP[monke];
        makexpr(RIGHT[monke]); printf ")";
    }
    else printf "%d", VAL[monke];
}

END { makexpr(LEFT["root"]); printf "="; makexpr(RIGHT["root"]) } 
