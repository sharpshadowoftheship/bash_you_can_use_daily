#!/bin/bash


#This scirpt removes all "LAN"-like named connections


tmpfile=$(date +%N)

touch $tmpfile

nmcli connection show | cut -f1 -d" " | grep '^LAN' >$tmpfile

while [ $(wc -c $tmpfile | cut -f1 -d" ") -ne 0 ]
do
        lastline=$(tail -1 $tmpfile)
        tmpfile2=$(date +%N)
        nmcli connection delete $lastline &>/dev/null
        sed '$d' $tmpfile>$tmpfile2
        mv $tmpfile2 $tmpfile
done

rm $tmpfile $tmpfile2 &>/dev/null