awk '{for(i=1;i<=length();++i) print substr($0, i, 14)}' <in.txt |
awk '{for(i=1;i<length();++i) for(j=i+1;j<=length();++j) if(substr($0,i,1)==substr($0,j,1)) next} {print 13+NR; exit}'
