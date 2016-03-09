#!/bin/sh

pa1="/home/msg/M"
pa2=`date "+%m"`
pd="/D"
pa3=`date "+%d"`
ph="/H"
pa4=`date "+%H"`

listtaf=`find $pa1$pa2$pd$pa3$ph$pa4 -type f -mmin -15 -exec grep 'TAF UKOH' {} \;`

if [ "$listtaf" == "" ];
then
    aplay /home/briz/etc/sounds/allert.wav
    aplay /home/briz/etc/sounds/taf_mail_error.wav
    rm /home/briz/tmp/taf_mail.dat
else
    file_taf=`find $pa1$pa2$pd$pa3$ph$pa4 -type f -mmin -15 -exec grep -l 'TAF UKOH' {} \;`
    cat $file_taf | sed -n '/TAF UKOH/,/=/p' | tr -d '\r\n' | sed -r 's/=.+//' | sed s/$/=/g | tr -s [:blank:] | sed 's/==/=/' > /home/briz/tmp/taf_mail.dat
fi
