#!/bin/bash

table1=$1
howmanycol1=$2
table2=$3
howmanycol2=$4


for((i=1; i<=howmanycol1; i++))
do
        for((j=1; j<=howmanycol2; j++))
        do
                if [ $(awk -F'\t' "{print $"${i}"}"  $table1 | head -1) = $(awk -F'\t' "{print $"${j}"}"  $table2 | head -1) ]
                then
                        tmp=$(awk -F'\t' "{print $"${i}"}"  $table1 | head -1)
                fi
        done
done
#echo $tmp