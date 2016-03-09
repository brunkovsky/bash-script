#!/bin/sh

# определяем переменные для пути и имени файлов
varcp="/home/arm/MAPS/"
varqyua98="QYUA98 UKMS "
vardate=`date "+%d"`
vardateall=`date`
varhour=`date "+%H"`
# varhour="09"
varzero="00"

# объявляем переменные-длины листа для печати
declare -i q98=0
declare -i heightlist

# определяем рабочий каталог
cd /home/briz/tmp

# удаляем предыдущий файл карт
rm /home/briz/tmp/result_mk.ps

# копируем карты в рабочий каталог
cp "$varcp$varqyua98$vardate$varhour$varzero.BMP" /home/briz/tmp/qyua98.bmp
cp "$varcp$varqyua98$vardate$varhour$varzero.bmp" /home/briz/tmp/qyua98.bmp

# поворачиваем и кадрируем (ImageMagick)
convert -rotate 90 -gravity SouthEast -chop 0x60 qyua98.bmp qyua98_.bmp

# проверяем наличие всех файлов карт
# и устанавливаем соответствующую длину печатаемого листа
if test -f "qyua98_.bmp"
then
    q98=1360
else
    aplay /home/briz/etc/sounds/allert.wav
    aplay /home/briz/etc/sounds/qypa98_error.wav
fi

heightlist=$(( q98 ))

# конвертируем в pdf, потом в PostScript (ImageMagick)
convert -density 36x36 qyua98_.bmp result_.pdf
convert result_.pdf result_mk.ps

# удаляем временные файлы
rm qyua98.bmp
rm qyua98_.bmp
rm result_.pdf

# если получилось создать файл - печатаем
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
