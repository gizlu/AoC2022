#!/usr/bin/awk -f
function sign(x) { return x < 0 ? -1 : x > 0 }
function abs(x) { return sqrt(x*x) }
function movetail(head, tail) {
    x_dist = (X[head] - X[tail]); 
    y_dist = (Y[head] - Y[tail]);
    if(abs(x_dist) > 1) { # horizontal or diagonal move
        if(abs(y_dist) == 1) Y[tail] = Y[head] # diagonal move
        X[tail] += x_dist - sign(x_dist)
    } if(abs(y_dist) > 1) { # vertical or diagonal move
        if(abs(x_dist) == 1) X[tail] = X[head]; # diagonal move
        Y[tail] += y_dist - sign(y_dist)
    }
}
function update(i)
{
    for(i=1; i<10; ++i) movetail(i-1, i)
    LUT[X[9], Y[9]];
}
$1=="R" { for(i=0;i<$2;++i) {++X[0]; update()} }
$1=="L" { for(i=0;i<$2;++i) {--X[0]; update()} }
$1=="U" { for(i=0;i<$2;++i) {++Y[0]; update()} }
$1=="D" { for(i=0;i<$2;++i) {--Y[0]; update()} }
END { for(pos in LUT) ++count; print count }
