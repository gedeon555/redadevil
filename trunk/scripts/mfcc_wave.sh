#!/bin/sh
##
## mfcc.sh
## 
## Made by Homerlan
## Login   <homerlan@homerlan>
## 
## Started on  Mon Nov 26 16:06:55 2007 Homerlan
## Last update Wed Nov 28 17:01:48 2007 Homerlan
##

if [ $# -lt 2 ]; then
    echo "usage: mfcc_wave.sh sph_files_dir htk_config_file";
    exit 0
fi

for i in $1/speech-*.wav;
do
    echo "Computing MFCC for file $i...";
    file_tmp=`echo $i | sed 's/.wav/.tmp/g'`
    file_mfcc=`echo $i | sed 's/.wav/.mfcc/g'`
    HCopy -C $2 $i $file_tmp
    HList -r $file_tmp > $file_mfcc
    rm -rf $file_tmp
done