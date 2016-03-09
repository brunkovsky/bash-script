#!/bin/sh

pa1="/home/msg/M"
pa2=`date "+%m"`
pd="/D"
pa3=`date "+%d"`
ph="/H"
pa4=`date "+%H"`

list=`find $pa1$pa2$pd$pa3$ph$pa4 -type f -mmin -6 -exec grep 'METAR UKOH' {} \;`

if [ "$list" == "" ];
then
    aplay /home/briz/etc/sounds/allert.wav
    aplay /home/briz/etc/sounds/METAR_error.wav
else
    aplay /home/briz/etc/sounds/METAR_send.wav
fi
