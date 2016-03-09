#!/bin/sh

export LANG=ru_RU.KOI8-R
export LANGUAGE=ru
export LC_CTYPE=ru_RU.KOI8-R

cd /home/briz/tmp/

date1=`date +%F`
date2=`date -d -1day +%F`
H12=`date +%H`
M12=`date +%M`
S12=`date +%S`

wget -O rawfile --user=userName --password=userPassword "http://gcst.meteo.gov.ua/****/****/blanks.phtml?T1=UKOH&blank=zipfile&nabors=&numb=50&srok=$date1+$H12%3A$M12%3A$S12&dosrok=$date2+$H12%3A$M12%3A$S12&SA=on&SP=on&FC=on&FT=on"

cat rawfile | grep "METAR\|=" | tr -s [:blank:] | tr -d '\r\n' | tr "\=" "\n" | sed s/$/=/g | grep "METAR" > file_met
cat rawfile | grep "TAF\|=" | tr -s [:blank:] | tr -d '\r\n' | tr "\=" "\n" | sed s/$/=/g | grep "TAF" > file_taf
cat rawfile | grep "SPECI\|=" | tr -s [:blank:] | tr -d '\r\n' | tr "\=" "\n" | sed s/$/=/g | grep "SPECI" > file_spe

echo "                                                                       âĚÁÎË áđđ" > file_app
echo "                              đĎÇĎÄÁ ĐĎ ÁĹŇĎÄŇĎÍÁÍ" >> file_app
echo $date1 $H12:$M12 >> file_app
echo "" >> file_app
echo "SA ćÁËÔÉŢÎÁ ĐĎÇĎÄÁ ĐĎ ÁĹŇĎÄŇĎÍŐ:" >> file_app
cat file_met >> file_app
echo "" >> file_app
echo "SP űÔĎŇÍĎ×Á ĐĎÇĎÄÁ ĐĎ ÁĹŇĎÄŇĎÍŐ:" >> file_app
cat file_spe >> file_app
echo "" >> file_app
echo "FC đŇĎÇÎĎÚ ĐĎÇĎÄÉ ĐĎ ÁĹŇĎÄŇĎÍŐ:" >> file_app
cat file_taf >> file_app

a2ps file_app --columns=1 -R -B -E -o file_app.ps
ps2pdf -sPAPERSIZE=a4 file_app.ps file_app.pdf

mkdir /home/briz/Desktop/SaveDataRemote
mkdir /home/briz/Desktop/SaveDataRemote/`date "+%Y"`
mkdir /home/briz/Desktop/SaveDataRemote/`date "+%Y"`/`date "+%m"`
mv file_app.pdf /home/briz/Desktop/SaveDataRemote/`date "+%Y"`/`date "+%m"`/`date "+%d"`_`date "+%m"`_`date "+%C"``date "+%y"`.pdf

mutt -s "Save METAR, TAF, SPECI from CGM-site" -a /home/briz/Desktop/SaveDataRemote/`date "+%Y"`/`date "+%m"`/`date "+%d"`_`date "+%m"`_`date "+%C"``date "+%y"`.pdf amsg-cloud@yandex.ru < /dev/null

rm rawfile file_met file_taf file_spe  file_app file_app.ps
#rm `date "+%d"`_`date "+%m"`_`date "+%C"``date "+%y"`.pdf
