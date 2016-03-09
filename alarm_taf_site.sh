#!/bin/sh

export LANG=ru_RU.KOI8-R
export LANGUAGE=ru
export LC_CTYPE=ru_RU.KOI8-R

date1=`date +%F`
date2=`date -d -1day +%F`
H12=`date +%H`
M12=`date +%M`
S12=`date +%S`

wget -O rawfiletaf --user=userName --password=userPassword "http://********.***.**/*****/****/blanks.phtml?T1=UKOH&blank=zipfile&nabors=&numb=1&srok=$date1+$H12%3A$M12%3A$S12&dosrok=$date2+$H12%3A$M12%3A$S12&SA=off&SP=off&FC=on&FT=off"

cat rawfiletaf | grep "TAF\|=" | tr -s [:blank:] | tr -d '\r\n' | tr "\=" "\n" | sed s/$/=/g | grep "TAF" > file_taf

#result=`cat /home/briz/scripts/file_met|awk ' {print $0} '`
#echo $result
#cat file_met | cut -c 12-13 > file_met_D
cat file_taf | cut -c 12-13 > file_taf_H
#cat file_taf | cut -c 16-17 > file_taf_M

if [ `cat file_taf_H` == $H12 ]
then
    #echo 1
    aplay /home/briz/etc/sounds/TAF_send.wav
else
    #echo 0
    aplay /home/briz/etc/sounds/allert.wav
    /home/briz/scripts/alarm_taf.sh
fi

rm rawfiletaf file_taf file_taf_H
