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
python3 ./Tools/knock/knockpy.py $i -o ./$i/Knock
# All in One Subdomains
cat ./$i/Subs/* >> ./$i/Subs/allhost.txt

# Remove un-used subs and folder...

# Time For Alive Subdomain's
cat ./$i/Subs/allhost.txt | anew | tee ./$i/Subs/Sub-domain.txt
cat ./$i/Subs/Sub-domain.txt | httprobe > ./$i/Subs/Alive.txt


#--------------------
mkdir ./$i/Nuclei-Result
echo "Scan for exposed-panels started ...."
nuclei -l $i/Subs/amass.txt -t exposed-panels/ -o $i/Nuclei-Result/exposed-panels.txt


echo "Scan for Technologies started ..."
nuclei -l $i/Subs/amass.txt -t technologies/ -o $i/Nuclei-Result/technologies.txt


echo "Scan for cnvd  started....."
nuclei -l $i/Subs/amass.txt -t cnvd/ -o $i/Nuclei-Result/cnvd.txt 



echo "Scan for exposures started....."
nuclei -l $i/Subs/amass.txt -t exposures/ -o $i/Nuclei-Result/exposures.txt



echo "Scan for files  started....."
nuclei -l $i/Subs/amass.txt -t file/ -o $i/Nuclei-Result/file.txt

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
echo "Scan for miscellaneous started....."
nuclei -l $i/Subs/Alive.txt -t miscellaneous/ -o $i/Nuclei-Result/miscellaneous.txt


echo "Scan for misconfiguration started....."
nuclei -l $i/Subs/amass.txt -t misconfiguration/ -o $i/Nuclei-Result/misconfiguration.txt


echo "Scan for vulnerabilities started ..."
nuclei -l $i/Subs/amass.txt -t vulnerabilities/ -o $i/Nuclei-Result/vulnerabilities.txt

# Nuclie Scan Done ........................

# Starting Urls Grabbing And Shorting
mkdir $i/Urls
cat $i/Subs/amass.txt | waybackurls > $i/Urls/Urls.txt
cat $i/Subs/amass.txt | gau --threads 5 > $i/Urls/Urls2.txt

cat ./$i/Urls/* >> ./$i/Urls/All.txt
cat ./$i/Urls/All.txt | anew | tee ./$i/Urls/Unique.txt



# ScreenShooting the subdomains we get 
 mkdir $i/Images/
 
 gowitness file -f $i/Subs/amass.txt


