#!/bin/sh

export LANG=ru_RU.KOI8-R
export LANGUAGE=ru
export LC_CTYPE=ru_RU.KOI8-R

date1=`date +%F`
date2=`date -d -1day +%F`
H12=`date +%H`
M12=`date +%M`
S12=`date +%S`

wget -O rawfile --user=hersonmet --password=+tfxDWBf{X "http://gcst.meteo.gov.ua/armua/avia/blanks.phtml?T1=UKOH&blank=zipfile&nabors=&numb=1&srok=$date1+$H12%3A$M12%3A$S12&dosrok=$date2+$H12%3A$M12%3A$S12&SA=on&SP=off&FC=off&FT=off"

cat rawfile | grep "METAR\|=" | tr -s [:blank:] | tr -d '\r\n' | tr "\=" "\n" | sed s/$/=/g | grep "METAR" > file_met

#result=`cat /home/briz/scripts/file_met|awk ' {print $0} '`
#echo $result
#cat file_met | cut -c 12-13 > file_met_D
cat file_met | cut -c 14-15 > file_met_H
cat file_met | cut -c 16-17 > file_met_M

if [ $M12 == 03 ]
then 
    if [ `cat file_met_H` == $H12 ] && [ `cat file_met_M` == 00 ]
    then
	echo 1
	aplay /home/briz/etc/sounds/METAR_send.wav
    else
	echo 2
	aplay /home/briz/etc/sounds/allert.wav
	/home/briz/scripts/alarm_metar.sh
    fi
else
    echo 3
    #./alarm_metar.sh
fi
if [ $M12 == 33 ]
then
    if [ `cat file_met_H` == $H12 ] && [ `cat file_met_M` == 30 ]
    then
	echo 4
        aplay /home/briz/etc/sounds/METAR_send.wav
    else
	echo 5
	aplay /home/briz/etc/sounds/allert.wav
	/home/briz/scripts/alarm_metar.sh
    fi
else
    echo 6
    #./alarm_metar.sh
fi

rm rawfile file_met file_met_M file_met_H
