#!/bin/bash

##batch wrapper per opensubdownloader
#set -x
set -e

cd $1

for file in *.mp4
do
  if [ ! -d "$file" ]
  then
    sub="${file%.*}"
    if [ ! -f "$sub".srt ]
    then
      OpenSubtitlesDownload.py -a $file
    else
      echo $file ": sottotitolo presente"
    fi
  fi
done
