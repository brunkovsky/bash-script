#!/bin/sh

export LANG=ru_RU.KOI8-R
export LANGUAGE=ru
export LC_CTYPE=ru_RU.KOI8-R

pa1="/home/msg/M"
pa2=`date "+%m"`
pd="/D"
pa3=`date "+%d"`

find $pa1$pa2$pd$pa3 -type f -ctime -1 -exec grep -l ' λιθε ' {} \; -exec cat {} \; > text.txt
cat text.txt | sed '/msg/g' | sed '/\x01[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]/d' | sed '$d' > text_.txt

a2ps text_.txt --columns=1 -R -B -E -o text.ps
ps2pdf -sPAPERSIZE=a4 text.ps text.pdf

mkdir /home/briz/Desktop/SaveDataLocal
mkdir /home/briz/Desktop/SaveDataLocal/`date "+%Y"`
mkdir /home/briz/Desktop/SaveDataLocal/`date "+%Y"`/`date "+%m"`

mv text.pdf /home/briz/Desktop/SaveDataLocal/`date "+%Y"`/`date "+%m"`/`date "+%d"`_`date "+%m"`_`date "+%C"``date "+%y"`.pdf

rm text.txt text_.txt text.ps
