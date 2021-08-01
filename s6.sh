#!/bin/bash



tmp=$(date +%N)
ps --user=$1>$tmp
tmp2=$(date +%N)
cat $tmp | tr -s ' ' | cut -f2 -d" " | sed 's/PID//'>$tmp2


while [ $(wc -c $tmp2 | cut -f1 -d" ") -ne 0 ]
do
        tmp3=$(date +%N)
        lastline=$(tail -1 $tmp2)
        kill -9 $lastline &>/dev/null
        sed '$d' $tmp2>$tmp3
        mv $tmp3 $tmp2
done