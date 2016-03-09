#!/bin/sh

# определяем переменные для пути и имени файлов
varcp="/home/arm/MAPS/"
varqyua98="QYUA98 UKMS "
varpyua98="PYUA98 RUMS "
varpyua85="PYUA85 RUMS "
varpyua70="PYUA70 RUMS "
varpyua50="PYUA50 RUMS "
vardate=`date "+%d"`
varzero="0000"

# объявляем переменные-длины листа для печати
declare -i q98=0
declare -i p98=0
declare -i p85=0
declare -i p70=0
declare -i p50=0
declare -i heightlist

# удаляем предыдущий файл карт
rm /home/briz/tmp/result.ps

# копируем карты в рабочий каталог
cp "$varcp$varqyua98$vardate$varzero.BMP" /home/briz/tmp/qyua98.bmp
cp "$varcp$varqyua98$vardate$varzero.bmp" /home/briz/tmp/qyua98.bmp
cp "$varcp$varpyua98$vardate$varzero.BMP" /home/briz/tmp/pyua98.bmp
cp "$varcp$varpyua98$vardate$varzero.bmp" /home/briz/tmp/pyua98.bmp
cp "$varcp$varpyua85$vardate$varzero.BMP" /home/briz/tmp/pyua85.bmp
cp "$varcp$varpyua85$vardate$varzero.bmp" /home/briz/tmp/pyua85.bmp
cp "$varcp$varpyua70$vardate$varzero.BMP" /home/briz/tmp/pyua70.bmp
cp "$varcp$varpyua70$vardate$varzero.bmp" /home/briz/tmp/pyua70.bmp
cp "$varcp$varpyua50$vardate$varzero.BMP" /home/briz/tmp/pyua50.bmp
cp "$varcp$varpyua50$vardate$varzero.bmp" /home/briz/tmp/pyua50.bmp

# определяем рабочий каталог
cd /home/briz/tmp/

# поворачиваем и кадрируем (ImageMagick)
convert -rotate 90 -gravity SouthEast -chop 0x60 qyua98.bmp qyua98_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 pyua98.bmp pyua98_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 pyua85.bmp pyua85_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 pyua70.bmp pyua70_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 pyua50.bmp pyua50_.bmp

# проверяем наличие всех файлов карт
# и устанавливаем соответствующую длину печатаемого листа
if test -f "qyua98_.bmp"
then
    q98=1300
else
    aplay /home/briz/etc/sounds/qypa98.error.wav
fi
if test -f "pyua98_.bmp"
then
    p98=950
else
    aplay /home/briz/etc/sounds/pyua98_error.wav
fi
if test -f "pyua85_.bmp"
then
    p85=950
else
    aplay /home/briz/etc/sounds/pyua85_error.wav
fi
if test -f "pyua70_.bmp"
then
    p70=950
else
    aplay /home/briz/etc/sounds/pyua70_error.wav
fi
if test -f "pyua50_.bmp"
then
    p50=950
else
    aplay /home/briz/etc/sounds/pyua50_error.wav
fi
heightlist=$(( p98 + p85 + p70 + p50 ))

# склеиваем (ImageMagick)
montage qyua98_.bmp pyua85_.bmp pyua98_.bmp pyua70_.bmp pyua50_.bmp -tile 1x5 -geometry +0+0 result_.bmp

# конвертируем в pdf, потом в PostScript (ImageMagick)
convert -density 38x38 result_.bmp result_.pdf
convert result_.pdf result.ps

# удаляем временные файлы
#rm qyua98.bmp pyua98.bmp pyua85.bmp pyua70.bmp pyua50.bmp
#rm qyua98_.bmp pyua98_.bmp pyua85_.bmp pyua70_.bmp pyua50_.bmp
#rm result_.bmp result_.pdf

# если получилось создать файл - печатаем
if test -f "result.ps"
then
    #lprm -
    #echo "$heightlist"
    #gs -q -r120x216 -dBATCH -dNOPAUSE -sDEVICE=eps9mid -dDEVICEWIDTHPOINTS=980 -dDEVICEHEIGHTPOINTS=$heightlist -dFIXEDMEDIA -sOutputFile=- result.ps|lpr -r
else
    aplay /home/briz/etc/sounds/print_error.wav
fi
