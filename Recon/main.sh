

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
echo " Scanning Started For --> $i"

sleep 3


# Creating directory
mkdir $i
# Creating Directory for Subdomain's
mkdir -p ./$i/Subs




# Subdomain's Finding ....
amass enum -d $i -o ./$i/Subs/amass.txt --passive
assetfinder $i | tee ./$i/Subs/asset.txt
subfinder -d $i | tee ./$i/Subs/finder.txt
curl -s https://crt.sh/\?q\=%25.$i\&output=json | jq -r  '.[].name_value' | sed 's/\*\.//g' | sort -u | tee ./$i/Subs/crt.txt

# All in One Subdomains
cat ./$i/Subs/* >> ./$i/Subs/allhost.txt
cat ./$i/Subs/allhost.txt | anew | tee ./$i/Subs/hosted.txt
cat ./$i/Subs/hosted.txt | httprobe > ./$i/Subs/AliveSubs.txt
grep "$i" ./$i/Subs/AliveSubs.txt > ./$i/Subs/hostbu.txt
cat hostbu.txt | sort -u > host.txt
echo "sleeping for 10 "

# Removing unwanted files.....
rm ./$i/Subs/amass.txt ./$i/Subs/asset.txt  ./$i/Subs/finder.txt  ./$i/Subs/jldc.txt ./$i/Subs/allhost.txt ./$i/Subs/AliveSubs.txt





echo " wack upsssssss"
sleep 5

mkdir ./$i/Network

#Network Enumeration
cat ./$i/Subs/host.txt | httpx -title -server -ip -sc -follow-redirects -random-agent -o ./$i/Network/ttps_r.txt -ports "80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672"

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

katana -list ./$i/Subs/host.txt -o ./$i/Urls/Katana.txt 

FILESO=./$i/Subs/host.txt
while read -r LINE
do
        (( count++ ))
        echo "$LINE" | waybackurls > ./$i/Urls/SeparateUrls/$count
done < $FILESO


cat ./$i/Urls/SeparateUrls/* >> ./$i/Urls/AllOne.txt
cat ./$i/Urls/AllOne.txt | anew | tee ./$i/Urls/Fine.txt
rm ./$i/Urls/AllOne.txt

cat ./$i/Urls/Fine.txt | grep "$i" | tee ./$i/Urls/TargetUrl.txt


mkdir ./$i/Arjun_out
FILEAR= ./$i/Urls/TargetUrl.txt
while read -r ALINE
do
        ((count++))
        arjun -i "$ALINE" --passive --stable -c 40 -d 0.30 -oT ./$i/Arjun_out/$count
done < $FILEAR

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
