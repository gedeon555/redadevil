#!/bin/sh
##
## mfcc.sh
## 
## Made by Homerlan
## Login   <homerlan@homerlan>
## 
## Started on  Mon Nov 26 16:06:55 2007 Homerlan
## Last update Tue Nov 27 11:41:17 2007 Homerlan
##

if [ $# -lt 2 ]; then
    echo "usage: mfcc.sh sph_files_dir htk_config_file";
    exit 0
fi

for i in $1/*.sph;
do
    echo "Computing MFCC for file $i...";
    HCopy -C $2 $i `echo $i | sed 's/.sph/.mfcc/g'`
done