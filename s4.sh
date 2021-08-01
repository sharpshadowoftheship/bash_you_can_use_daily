#!/bin/bash
while [ $(wc -c hasla.txt | cut -f1 -d" ") -ne 0 ]
do
        lastline=$(tail -1 hasla.txt)
        sshpass -p $lastline ssh elton@10.0.3.111 -p 2222
        sed '$d' hasla.txt > tmp.txt
        mv tmp.txt hasla.txt
done