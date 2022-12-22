#!/usr/bin/awk -f
BEGIN {FS="(: )|( )" }
NF==2 { VAL[$1]=$2 }
NF==4 { LEFT[$1]=$2; OP[$1]=$3; RIGHT[$1]=$4 }
function evall(monke) {
    if(monke in LEFT) {
        if(OP[monke]=="*") return evall(LEFT[monke]) * evall(RIGHT[monke]);
        if(OP[monke]=="/") return evall(LEFT[monke]) / evall(RIGHT[monke]);
        if(OP[monke]=="+") return evall(LEFT[monke]) + evall(RIGHT[monke]);
        if(OP[monke]=="-") return evall(LEFT[monke]) - evall(RIGHT[monke]);
    } else {
        return VAL[monke];
    }
}
# END { print evall("root") } 
END { print evall(RIGHT["root"]) } 
