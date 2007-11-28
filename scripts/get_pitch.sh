#!/bin/sh
##
## get_pitch.sh
## 
## Made by Homerlan
## Login   <homerlan@homerlan>
## 
## Started on  Wed Nov 28 17:01:31 2007 Homerlan
## Last update Wed Nov 28 17:20:47 2007 Homerlan
##

if [ $# -lt 2 ]; then
    echo "usage: get_pitch.sh sph_files_dir praat_script_dir";
    exit 0
fi

current=`pwd`
for i in $1/*.sph;
do
    echo "Computing pitch for file $i...";
    praat $2/get_pitch.praat $i
done