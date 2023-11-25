echo "Updating nuclei templates............"
nuclei --update-templates

echo "Updatations is completed................................"

read -p "Enter domain names seperated by 'space' : " input
for i in ${input[@]}
do
echo "Scan star for $i"
echo "$i Directery creating... "
mkdir $i
mkdir -p ./output/$i

amass enum -d $i -o ./output/$i/amass.txt --passive
assetfinder -subs-only $i | tee ./output/$i/assetfinder.txt
subfinder -d $i | tee ./output/$i/subfinder.txt

cat ./output/$i/* >> ./output/$i/allhost.txt

cat ./output/$i/allhost.txt | anew | tee ./output/$i/host.txt
cat ./output/$i/host.txt | httprobe > ./output/$i/subdomains.txt
cp ./output/$i/subdomains.txt ./$i/subdomains.txt -r

echo "Subdomains are saved at ./$i/subdomains.txt"
echo "====================--Subdomain Scaning Done--================================"

mkdir ./$i/Nuclei
echo "Scan for default-logins started ... "
nuclei -l $i/subdomains.txt -rl 20 -t default-logins/ -o ./$i/Nuclei/logins.txt

echo "Scan for exposed-panels started ...."
nuclei -l $i/subdomains.txt -t exposed-panels/ -o ./$i/Nuclei/exposed-panels.txt -rl 20

echo "Scan for DNS  started....."
nuclei -l $i/subdomains.txt -t dns/ -o ./$i/Nuclei/dns.txt  -rl 20

echo "Scan for cnvd  started....."
nuclei -l $i/subdomains.txt -t cnvd/ -o ./$i/Nuclei/cnvd.txt -rl 20

echo "Scan for exposures started....."
nuclei -l $i/subdomains.txt -t exposures/ -o ./$i/Nuclei/exposures.txt -rl 20

echo "Scan for files  started....."
nuclei -l $i/subdomains.txt -t file/ -o ./$i/Nuclei/file.txt -rl 20
 
echo "Scan for headless started....."
nuclei -l $i/subdomains.txt -t headless/ -o ./$i/Nuclei/headless.txt -rl 20

echo "Scan for iot  started....."
nuclei -l $i/subdomains.txt -t iot/ -o ./$i/Nuclei/iot.txt -rl 20

echo "Scan for miscellaneous started....."
nuclei -l $i/subdomains.txt -t miscellaneous/ -o ./$i/Nuclei/miscellaneous.txt -rl 20

echo "Scan for misconfiguration started....."
nuclei -l $i/subdomains.txt -t misconfiguration/ -o ./$i/Nuclei/misconfiguration.txt -rl 20

echo "Scan for Newtork  started....."
nuclei -l $i/subdomains.txt -t network/ -o ./$i/Nuclei/network.txt -rl 20

echo "Scan for SSL started ..."
nuclei -l $i/subdomains.txt -t ssl/ -o ./$i/Nucelei/ssl.txt -rl 20

echo "Scan for Takeover started ..."
nuclei -l $i/subdomains.txt -t takeovers/ -o ./$i/Nuclei/takeovers.txt -rl 20

echo "Scan for Technologies started ..."
nuclei -l $i/subdomains.txt -t technologies/ -o ./$i/Nuclei/technologies.txt -rl 20

echo "Scan for Token-spray started ..."
nuclei -l $i/subdomains.txt -t token-spray/ -o ./$i/Nuclei/token-spray.txt -rl 20


echo "Scan for CVES started..."
nuclei -l $i/subdomains.txt -t cves/ -o ./$i/Nuclei/cves.txt -rl 20

echo "Scan for vulnerabilities started ..."
nuclei -l $i/subdomains.txt -t vulnerabilities/ -o ./$i/Nuclei/vulnerabilities.txt -rl 20

done

echo "=========================---Finish---======================="
echo "Scaning Done."


mkdir ./$i/Nikto

nikto -h $i -Tuning 1,2,3,4,5,6,8,7,9,0,a,b,c -C all  -o ./$i/Nikto/Result.txt

mkdir ./$i/Wapiti

wapiti -u https://$i -m -o ./$i/Wapiti/Result.txt
