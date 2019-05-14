#!/bin/bash
#script to download tide station and wavebuoy data from NOAA

#define function to download and format data
GETDATA(){
	echo $1 ${2}
	FILE=$(echo ${1}h${2}.txt)

	#hyperlink to data, download, and unzip
	LINK=$(echo https://www.ndbc.noaa.gov/data/historical/stdmet/${FILE}.gz)
	wget $LINK
	gunzip ${FILE}.gz
}
export -f GETDATA

#download all station data from stations listed in file "stations" and years listed
#in file "years"
parallel -j 4 --no-notice "GETDATA {1} {2}" :::: stations years

#remove empty files
find -size  0 -print0 |xargs -0 rm --

ISOAIRT(){
	echo $1
	FILE=$1
	
	#extract line with highest temp, pull station metadata from buoy_tidestations.tab,
	#and append to file where each row is the highest temp from a given station in a
	#given year
	tail -n +3 ${FILE} | sed 's/ /\t/g' | sed 's/\t\t/\t/g' | sed 's/\t\t/\t/g' | cut -f1-3,14 | sed 's/999\.0//g' | sort -r -k4 | head -1 | paste -d "\t" - <(grep $(echo ${FILE%.*} | sed 's/h20.*//g') buoy_tidestations.tab) >> maxT.dat

}
export -f ISOAIRT

#remove the old max temp data file
rm maxT.dat

#run ISOAIRT on all station data
ls *h*txt | parallel -j 4 --no-notice "ISOAIRT {}"

#remove empty files
find -size  0 -print0 |xargs -0 rm --




