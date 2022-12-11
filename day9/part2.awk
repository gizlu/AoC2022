#!/usr/bin/awk -f
# BEGIN{X[0]=2137; Y[0]=2137}
function sign(x) { return x < 0 ? -1 : x > 0 }
function abs(x) { return sqrt(x*x) }
function movetail(head, tail) {
    # print X[head] "\t" Y[tail];
    print head"\t"tail
    x_dist = (X[head] - X[tail]); 
    y_dist = (Y[head] - Y[tail]);
    # print "dist: "x_dist "\t" y_dist;
    if(abs(x_dist) > 1) { # horizontal or diagonal move
        # print "tail:"X[tail]"\t"Y[tail];
        if(abs(y_dist) == 1) Y[tail] = Y[head] # diagonal move
        X[tail] += x_dist - sign(x_dist)
        # print "tail:"X[tail]"\t"Y[tail];
    } if(abs(y_dist) > 1) { # vertical or diagonal move
        if(abs(x_dist) == 1) X[tail] = X[head]; # diagonal move
        Y[tail] += y_dist - sign(y_dist)
    }
    print X[head]","Y[head]"\t"X[tail]","Y[tail];
}

function update(i)
{
    # print X[0];
    for(i=1; i<10; ++i) movetail(i-1, i)
    # print X[0]","Y[0]"\t"X[1]","Y[1];
    print X[8] "\t" Y[8];
    LUT[X[9], Y[9]];
}
# function print_tail() { print TAIL_X "\t" TAIL_Y }
$1=="R" { for(i=0;i<$2;++i) {++X[0]; update()} }
$1=="L" { for(i=0;i<$2;++i) {--X[0]; update()} }
$1=="U" { for(i=0;i<$2;++i) {++Y[0]; update()} }
$1=="D" { for(i=0;i<$2;++i) {--Y[0]; update()} }
# { print X[9] "\t" Y[9]; }
END { for(pos in LUT) ++count; print count }
