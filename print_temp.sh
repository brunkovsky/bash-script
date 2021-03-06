#!/bin/sh

# ���������� ���������� ��� ���� � ����� ������
#varcp="/home/arm/MAPS/"
#varpyua98="PYUA98 RUMS "
#varpyua85="PYUA85 RUMS "
#varpyua70="PYUA70 RUMS "
#varpyua50="PYUA50 RUMS "
#vardate=`date "+%d"`
#varzero="0000"

# ��������� ����������-����� ����� ��� ������
declare -i p98=0
declare -i p85=0
declare -i p70=0
declare -i p50=0
declare -i heightlist

# ������� ���������� ���� ����
#rm /home/briz/tmp/result.ps

# �������� ����� � ������� �������
#cp "$varcp$varpyua98$vardate$varzero.BMP" /home/briz/tmp/pyua98.bmp
#cp "$varcp$varpyua98$vardate$varzero.bmp" /home/briz/tmp/pyua98.bmp
#cp "$varcp$varpyua85$vardate$varzero.BMP" /home/briz/tmp/pyua85.bmp
#cp "$varcp$varpyua85$vardate$varzero.bmp" /home/briz/tmp/pyua85.bmp
#cp "$varcp$varpyua70$vardate$varzero.BMP" /home/briz/tmp/pyua70.bmp
#cp "$varcp$varpyua70$vardate$varzero.bmp" /home/briz/tmp/pyua70.bmp
#cp "$varcp$varpyua50$vardate$varzero.BMP" /home/briz/tmp/pyua50.bmp
#cp "$varcp$varpyua50$vardate$varzero.bmp" /home/briz/tmp/pyua50.bmp

# ���������� ������� �������
cd /home/briz/tmp1/

# ������������ � ��������� (ImageMagick)
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 PYUA98.bmp pyua98_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 PYUA85.bmp pyua85_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 PYUA70.bmp pyua70_.bmp
convert -gravity NorthWest -chop 69x0 -gravity SouthEast -chop 418x1150 PYUA50.bmp pyua50_.bmp

# ��������� ������� ���� ������ ����
# � ������������� ��������������� ����� ����������� �����
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

# ��������� (ImageMagick)
montage pyua85_.bmp pyua98_.bmp pyua70_.bmp pyua50_.bmp -tile 1x4 -geometry +0+0 result_.bmp

# ������������ � pdf, ����� � PostScript (ImageMagick)
convert -density 38x38 result_.bmp result_.pdf
convert result_.pdf result.ps

# ������� ��������� �����
#rm pyua98.bmp pyua85.bmp pyua70.bmp pyua50.bmp
#rm pyua98_.bmp pyua85_.bmp pyua70_.bmp pyua50_.bmp
#rm result_.bmp result_.pdf

# ���� ���������� ������� ���� - ��������
if test -f "result.ps"
then
    #lprm -
    #echo "$heightlist"
    gs -q -r120x216 -dBATCH -dNOPAUSE -sDEVICE=eps9mid -dDEVICEWIDTHPOINTS=980 -dDEVICEHEIGHTPOINTS=$heightlist -dFIXEDMEDIA -sOutputFile=- result.ps|lpr -r
else
    aplay /home/briz/etc/sounds/print_error.wav
fi
