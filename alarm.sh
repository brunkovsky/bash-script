#!/bin/sh

/home/briz/bin/rspdump_www

result1=`cat /home/briz/tmp/XVZdump|grep ןהוף_och_out|awk -F= {'print $2'}`
if [ "$result1" != "0"  ] 
then
aplay /home/briz/etc/sounds/ODM_out_error.wav
aplay /home/briz/etc/sounds/allert.wav
aplay /home/briz/etc/sounds/ODM_out_error.wav
#echo "alarm!!!";
fi

result2=`cat /home/briz/tmp/XVZdump|grep ןהוף_PD_ERROR|awk -F= {'print $2'}`
if [ "$result2" != "0"  ] 
then
aplay /home/briz/etc/sounds/ODM_link_error.wav
aplay /home/briz/etc/sounds/allert.wav
aplay /home/briz/etc/sounds/ODM_link_error.wav
#echo "alarm!!!";
fi

result3=`cat /home/briz/tmp/XVZdump|grep םמפע_och_out|awk -F= {'print $2'}`
if [ "$result3" != "0"  ] 
then
aplay /home/briz/etc/sounds/MNTR_receive.wav
aplay /home/briz/etc/sounds/allert.wav
aplay /home/briz/etc/sounds/MNTR_receive.wav
#echo "alarm!!!";
fi

result4=`cat /home/briz/tmp/XVZdump|grep עוהת_och_out|awk -F= {'print $2'}`
if [ "$result4" != "0"  ] 
then
aplay /home/briz/etc/sounds/REDZ_receive.wav
aplay /home/briz/etc/sounds/allert.wav
aplay /home/briz/etc/sounds/REDZ_receive.wav
#echo "alarm!!!";
fi

result5=`cat /home/briz/tmp/XVZdump|grep נעןח_och_out|awk -F= {'print $2'}`
if [ "$result5" != "0"  ] 
then
aplay /home/briz/etc/sounds/allert.wav
#echo "alarm!!!";
fi

result6=`cat /home/briz/tmp/XVZdump|grep ûפעם_och_out|awk -F= {'print $2'}`
if [ "$result6" != "0"  ] 
then
aplay /home/briz/etc/sounds/STORM_receive.wav
aplay /home/briz/etc/sounds/allert.wav
aplay /home/briz/etc/sounds/STORM_receive.wav
#echo "alarm!!!";
fi

exit 0