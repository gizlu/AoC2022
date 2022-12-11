#!/usr/bin/awk -f
function sign(x) { return x < 0 ? -1 : x > 0 }
function abs(x) { return sqrt(x*x) }
function tailupdate() {
    x_dist = (HEAD_X - TAIL_X); 
    y_dist = (HEAD_Y - TAIL_Y);
    if(abs(x_dist) > 1) { # horizontal or diagonal move
        if(abs(y_dist) == 1) TAIL_Y = HEAD_Y # diagonal move
        TAIL_X += x_dist - sign(x_dist)
    } if(abs(y_dist) > 1) { # vertical or diagonal move
        if(abs(x_dist) == 1) TAIL_X = HEAD_X; # diagonal move
        TAIL_Y += y_dist - sign(y_dist)
    }
    LUT[TAIL_X, TAIL_Y];
}
$1=="R" { for(i=0;i<$2;++i) {++HEAD_X; tailupdate()} }
$1=="L" { for(i=0;i<$2;++i) {--HEAD_X; tailupdate()} }
$1=="U" { for(i=0;i<$2;++i) {++HEAD_Y; tailupdate()} }
$1=="D" { for(i=0;i<$2;++i) {--HEAD_Y; tailupdate()} }
END { for(pos in LUT) ++count; print count }
