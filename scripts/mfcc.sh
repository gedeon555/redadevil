#!/bin/sh
##
## mfcc.sh
## 
## Made by Homerlan
## Login   <homerlan@homerlan>
## 
## Started on  Mon Nov 26 16:06:55 2007 Homerlan
## Last update Mon Nov 26 16:15:35 2007 Homerlan
##

for i in $1/*.sph;
do
    echo "Computing MFCC for file $i...";
    HCopy -C $2 $i `echo $i | sed 's/.sph/.mfcc/g'`
done