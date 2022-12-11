#!/usr/bin/awk -f
BEGIN { N = -1 }
/Monkey/ { N++; }
/items/ { gsub($0, ",", ""); COUNT[N] = NF-2; }
/items/ { for(i=1;i<=COUNT[N];++i) ITEMS[N,i]=$(2+i) }
/Operation/ {operandA[N]=$4; operator[N]=$5; operandB[N]=$6 }
/Test/ { TEST[N]=$4 } # assume that only divisilibity is tested
/true/ { TRUE_TROW[N]=$6 }
/false/ { FALSE_TROW[N]=$6; }
# /false/ { print_monke(N); 
# print "test:"TEST[N]; print "FALSE:"FALSE_TROW[N]; print "TRUE:"TRUE_TROW[N]
# print "operandA:"operandA[N]; print "operator:"operator[N]; print "operandB:"operandB[N];}

function inspect(monke_n, item_n,
i,a,op,b,new)
{
    ++inspections[monke_n];
    a=operandA[monke_n]; op=operator[monke_n]; b=operandB[monke_n];
    if(a=="old") a=ITEMS[monke_n,item_n];
    if(b=="old") b=ITEMS[monke_n,item_n];
    if(op=="*") new=int((a*b)/3);
    else if(op=="+") new=int((a+b)/3);
    else { print "undefined operator"; exit(1) };
    ITEMS[monke_n,item_n]=new;
}
function throw(monke_n, item_n, 
i,new_monke_n)
{
    # print TEST[monke_n]; print ITEMS[monke_n,item_n]
    if(ITEMS[monke_n,item_n] % TEST[monke_n] == 0) new_monke_n=TRUE_TROW[monke_n];
    else new_monke_n=FALSE_TROW[monke_n];
    # print FALSE_TROW[monke_n];
    COUNT[new_monke_n]++;
    ITEMS[new_monke_n,COUNT[new_monke_n]]=ITEMS[monke_n,item_n];
}
function turn(monke_n,
i)
{
    for(i=1;i<=COUNT[monke_n];++i) {
        inspect(monke_n, i);
        throw(monke_n, i);
        # delete ITEMS[monke_n,i]
    }
    COUNT[monke_n]=0;
}
function print_monke(monke_n, i)
{
    for(i=1;i<=COUNT[monke_n];++i) {
        printf "%d ", ITEMS[monke_n,i]
    }
    print ""
}
# function print_monke_verbose(monke_n)
# {
#     printf "TEST:"TEST[monke_n]" TRUE "
# }
function round(i)
{
    # turn(0); print_monke(2); print_monke(3);
    for(i=0;i<=N;++i) { turn(i);
        # printf "%d ", FALSE_TROW[i]; print_monke(FALSE_TROW[i]);
        # printf "%d ", TRUE_TROW[i]; print_monke(TRUE_TROW[i]);
    }
    # for(i=0;i<=N;++i) { print_monke(i); }
    # for(i=0;i<=N;++i) { turn(i) }
    # for(i=0;i<=N;++i) { print_monke(i); }
}
END { for(i=0;i<20;++i) round(); }
END { for(i in inspections) print inspections[i]}
