#!/bin/bash

#this script removes all the users whose id is beetwen 3000 and 4000 with their home dirs


#we're generating temporary file that there's low possibility overwriting existing one
tmp1=$(date +%N)

touch $tmp1

awk -F: '{if($3>3000 && $3<4000)print $1}' /etc/passwd>$tmp1



while [ $(wc -c $tmp1 | cut -f1 -d" ") -ne 0 ]
do
        tmp2=$(date +%N)
        lastline=$(tail -1 $tmp1)
        sudo userdel -r $lastline &>/dev/null
        sed '$d' $tmp1>$tmp2
        mv $tmp2 $tmp1
done

rm $tmp1 $tmp2 &>/dev/null