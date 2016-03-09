#!/bin/sh

# ���������� ���������� ��� ���� � ����� ������
varcp="/home/arm/MAPS/"
varqyua98="QYUA98 UKMS "
vardate=`date "+%d"`
vardateall=`date`
varhour=`date "+%H"`
# varhour="09"
varzero="00"

# ��������� ����������-����� ����� ��� ������
declare -i q98=0
declare -i heightlist

# ���������� ������� �������
cd /home/briz/tmp

# ������� ���������� ���� ����
rm /home/briz/tmp/result_mk.ps

# �������� ����� � ������� �������
cp "$varcp$varqyua98$vardate$varhour$varzero.BMP" /home/briz/tmp/qyua98.bmp
cp "$varcp$varqyua98$vardate$varhour$varzero.bmp" /home/briz/tmp/qyua98.bmp

# ������������ � ��������� (ImageMagick)
convert -rotate 90 -gravity SouthEast -chop 0x60 qyua98.bmp qyua98_.bmp

# ��������� ������� ���� ������ ����
# � ������������� ��������������� ����� ����������� �����
if test -f "qyua98_.bmp"
then
    q98=1360
else
    aplay /home/briz/etc/sounds/allert.wav
    aplay /home/briz/etc/sounds/qypa98_error.wav
fi

heightlist=$(( q98 ))

# ������������ � pdf, ����� � PostScript (ImageMagick)
convert -density 36x36 qyua98_.bmp result_.pdf
convert result_.pdf result_mk.ps

# ������� ��������� �����
rm qyua98.bmp
rm qyua98_.bmp
rm result_.pdf

# ���� ���������� ������� ���� - ��������
if test -f "result_mk.ps"
then
    #lprm -
    #aplay /home/briz/etc/sounds/allert.wav
    #echo "$heightlist"
    gs -q -r120x216 -dBATCH -dNOPAUSE -sDEVICE=eps9mid -dDEVICEWIDTHPOINTS=980 -dDEVICEHEIGHTPOINTS=$heightlist -dFIXEDMEDIA -sOutputFile=- result_mk.ps|lpr -r
    #cp result_mk.ps /home/briz/tmp/maps/"mk_$vardateall.ps"
else
    aplay /home/briz/etc/sounds/allert.wav
    #aplay /home/briz/etc/sounds/print_error.wav
fi
