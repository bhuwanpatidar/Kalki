#!/bin/bash



echo "..........................................................."
echo ".                                                         ."
echo ".           __ __ ___    __    __ __ ____                 . "
echo ".          / //_//   |  / /   / //_//  _/                 ."
echo ".         / ,<  / /| | / /   / ,<   / /                   ."
echo ".        / /| |/ ___ |/ /___/ /| |_/ /                    ."
echo ".       /_/ |_/_/  |_/_____/_/ |_/___/                    ."
echo ".                           Author:- Bhuwan Patidar       ."
                                                       
echo "==========================================================="
echo ".                                                         ."
echo ".                                                         ." 
read -p ".    Enter domain name:  " i  
echo ". ________________________________________________________."

echo " "
echo " Scanning Started For $i"




# Creating directory
mkdir $i
# Creating Directory for Subdomain's
mkdir -p ./$i/Subs






# Subdomain's Finding ....
amass enum -d $i -o ./$i/Subs/amass.txt --passive
#assetfinder $i | tee ./$i/Subs/asset.txt
subfinder -d $i | tee ./$i/Subs/finder.txt
python3 ./Tool/knock/knockpy.py $i -o ./$i/


# All in One Subdomains
cat ./$i/Subs/* >> ./$i/Subs/allhost.txt
cat ./$i/Subs/allhost.txt | anew | tee ./$i/Subs/host.txt
cat ./$i/Subs/host.txt | httprobe > ./$i/Subs/subdomains.txt

#--------------------
echo "..........................................................."
echo ".                                                         ."
echo ".           __ __ ___    __    __ __ ____                 . "
echo ".                                                         ."
echo ".           __URL __ __GRABBING_    __    __ __ ____      . "
echo ".                                                         ."
echo ".                                                         ."
echo "..........................................................."
echo "Scanning Url May Take 1-x min according to number of Subdomains ."
echo "         Wait tool is utilizing your pricious time            "
mkdir ./$i/Urls
mkdir ./$i/Urls/SeparateUrls

FILESO=./$i/Subs/host.txt
while read -r LINE
do 
	(( count++ ))
	echo "$LINE" | waybackurls > ./$i/Urls/SeparateUrls/$count
done < $FILESO


cat ./$i/Urls/SeparateUrls/* >> ./$i/Urls/AllOne.txt
cat ./$i/Urls/AllOne.txt | anew | tee ./$i/Urls/Fine.txt

katana -list ./$i/Subs/host.txt -o ./$i/Urls/Katana.txt
cat ./$i/Urls/Fine.txt | grep "$i" | tee ./$i/Urls/TargetUrl.txt


echo "..........................................................."
echo ".                                                         ."
echo ".           __ __ ___    __    __ __ ____                 . "
echo ".                                                         ."
echo ".  _____     __JS__ ___ ENUMERATION   __    __ ____      . "
sleep 5
mkdir ./$i/Js
# Converting to Link for Enum

mkdir ./$i/Js/JsOut

cat ./$i/Urls/TargetUrl.txt | grep ".js" | tee ./$i/Js/JSLink.txt
r=0
FileJs=./$i/Js/JSLink.txt
while read -r JSLINE
do
	((r++))
	curl -s $JSLINE | tee ./Js/JsOut/$r
done < $FileJs

find ./$i/Js/JsOut/ -type f -size 0k -exec rm -v {} \;

nuclei -l ./$i/Js/JSLink.txt -t ~/nuclei-templates/exposures/ -o /$i/Js/NucleiResult.txt

echo "..........................................................."
echo ".                                                         ."
echo ".           __ __ ___    __    __ __ ____                 . "
echo ".                                                         ."
echo ".  _____     _Creating __Dic_tionary  __    __ ____      . "
sleep 5

mkdir ./$i/Dictionary 
mkdir ./$i/Dictionary/all 
dict=0
DicJs=./$i/Urls/TargetUrl.txt
while read -r DICLINE
do
	((dict++))
	curl -s $DICLINE | ./Tool/relative-url-extractor/extract.rb | tee ./$i/Dictionary/all/$dict	
done < $DicJs

find ./$i/Dictionary/all/ -type f -size 0k -exec rm -v {} \;

cat ./$i/Dictionary/all/* >> ./$i/Dictionary/One.txt

cat ./$i/Dictionary/One.txt | anew | ./$i/Dictionary/Final.txt

rm One.txt

