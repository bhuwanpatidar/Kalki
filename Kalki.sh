sudo echo "Kalki"
read -p "Enter domain name : " i
echo "Scan start for $i"
echo "$i Directery creating... "
mkdir -p ./Output/$i
mkdir -p ./Output/$i/Subdomain
mkdir -p ./Output/$i/Subdomain/All
mkdir -p ./Output/$i/Github
mkdir -p ./Output/$i/Urls
mkdir -p ./Output/$i/Nuclei
sudo cp ./Tools/Progress.txt ./Output/$i/
sudo sed -i "s/|     Creating Folders                  |      Incomplete                    |/|     Creating Folders                  |      Done                          |/g" ./Output/$i/Progress.txt


#curl -s https://crt.sh/\?q\=\$i\&output\=json | jq -r '.[].name_value' | grep -Po '(\w+\.\w+\.\w+)$' | tee ./Output/$i/Subdomain/All/certsh.txt #Subdomain Enum using Certsh
#x amass enum -d $i -o ./Output/$i/Subdomain/All/amass.txt --passive
# assetfinder -subs-only $i | tee ./Output/$i/Subdomain/All/assetfinder.txt
#subfinder -d $i | tee ./Output/$i/Subdomain/All/subfinder.txt
sudo sed -i "s/|     Subdomain Enumeration             |      Incomplete                    |/|     Subdomain Enumeration             |      Done                          |/g" ./Output/$i/Progress.txt




#cat ./Output/$i/Subdomain/All/* >> ./Output/$i/Subdomain/All/allhost.txt
#cat ./Output/$i/Subdomain/All/allhost.txt | anew | tee ./Output/$i/Subdomain/Allhost.txt
#cat ./Output/$i/Subdomain/Allhost.txt | httprobe > ./Output/$i/Subdomain/Alivesubdomains.txt
sudo sed -i "s/|     Subdomain Filtration              |      Incomplete                    |/|     Subdomain Filtration              |      Done                          |/g" ./Output/$i/Progress.txt



#xterm -e python3 ./Tools/gitdorker/GitDorker.py -q $i -tf ./Tools/gitdorker/tf/TOKENSFILE -d ./Wordlist/Github.txt --output ./Output/$i/Github/so.txt
sudo sed -i "s/|     GitHub Dorking                    |      Incomplete                    |/|     GitHub Dorking                    |      Done                          |/g" ./Output/$i/Progress.txt



#xterm -e nuclei -l ./Output/$i/Subdomain/Alivesubdomains.txt -t ./Tools/Template/1 -o ./Output/$i/Nuclei/shiv1.txt |sudo  sed -i "s/|     Nuclei Scan 1-2                   |      Incomplete                    |/|     Nuclei Scan 1-2                   |      Done                          |/g" ./Output/$i/Progress.txt
#xterm -e nuclei -l ./Output/$i/Subdomain/Alivesubdomains.txt -t ./Tools/Template/2 -o ./Output/$i/Nuclei/shiv2.txt



dig -f ./Output/$i/Subdomain/Alivesubdomains.txt +short | tee ./Output/$i/Subdomain/IP.txt

sudo cp ./Tools/Scanner.sh ./Output/$i/

#xterm -e nuclei -l ./Output/$i/Subdomain/Alivesubdomains.txt -t ./Tools/Template/3 -o ./Output/$i/Nuclei/shiv3.txt
#xterm -e nuclei -l ./Output/$i/Subdomain/Alivesubdomains.txt -t ./Tools/Template/3 -o ./Output/$i/Nuclei/shiv4.txt |sudo  sed -i "s/|     Nuclei Scan 3-4                   |      Incomplete                    |/|     Nuclei Scan 3-4                   |      Done                          |/g" ./Output/$i/Progress.txt



#cat ./Output/$i/Subdomain/Allhost.txt | waybackurls > ./Output/$i/Urls/Urls
sudo sed -i "s/|     Url Collecting                    |      Incomplete                    |/|     Url Collecting                    |      Done                          |/g" ./Output/$i/Progress.txt



#cat ./Output/$i/Urls/Urls | subjs > jslink
#xterm -e cat ./Output/$i/Urls/jslink | grep "\\.js" | xargs -n1 -I@ curl -k @ | tee -a jsfile.txt
sudo sed -i "s/|     JavaScript Enumeration            |      Incomplete                    |/|     JavaScript Enumeration            |      Done                          |/g" ./Output/$i/Progress.txt










