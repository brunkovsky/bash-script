#!/bin/sh

if [ -s "/home/briz/tmp/taf_mail.dat" ]
then
    cat /home/briz/tmp/taf_mail.dat | mutt -s "TAF Kherson" ctr_kherson@uksatse.aero
    aplay /home/briz/etc/sounds/taf_kdp_send_mail.wav
else
    aplay /home/briz/etc/sounds/taf_kdp_send_error.wav
fi
