#!/usr/bin/awk -f
function markline(x1, y1, x2, y2) {
    # yeah, we traverse each line twice. Too bad!
    for(x=x1; x>=x2; --x) BARIERS[x,y1]; # go left
    for(x=x1; x<=x2; ++x) BARIERS[x,y1]; # go right
    for(y=y1; y>=y2; --y) BARIERS[x1,y]; # go up
    for(y=y1; y<=y2; ++y) BARIERS[x1,y]; # go down
}
function markline2(left, right)
{
    split(left, l, ","); split(right, r, ",");
    markline(l[1], l[2], r[1], r[2]);
}
function updatemax(point) {
    split(point,p,",");
    if(p[2] > y_max) y_max=p[2];
}
{ for(i=3; i<=NF; i+=2) markline2($(i-2), $i) }
{ for(i=1; i<=NF; i+=2) updatemax($i) }

function canDescend(x,y) {
    return !((x,y+1) in BARIERS && (x-1,y+1) in BARIERS && (x+1,y+1) in BARIERS) && y <= y_max;
}
function dropsand()
{
    x=500; y=0;
    while(canDescend(x,y)) {
        y++;
        if((x,y) in BARIERS) x--;
        if((x,y) in BARIERS) x+=2;
    }
    if(y==0) { print N+1; exit(0) } # no sand can be longer produced
    BARIERS[x,y];
}
END { while(1) {dropsand();N++}}
