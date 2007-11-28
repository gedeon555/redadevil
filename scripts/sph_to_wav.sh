#!/bin/sh
##
## mfcc.sh
## 
## Made by Homerlan
## Login   <homerlan@homerlan>
## 
## Started on  Mon Nov 26 16:06:55 2007 Homerlan
## Last update Wed Nov 28 17:47:40 2007 Homerlan
##

if [ $# -lt 1 ]; then
    echo "usage: sph_to_wav.sh sph_files_dir";
    exit 0
fi

for i in $1/*.sph;
do
    echo "Generating wav file for $i...";
    file_wav=`echo $i | sed 's/.sph/.wav/g'`
    sox $i -s $file_wav
done