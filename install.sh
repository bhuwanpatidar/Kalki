mkdir Tools
git clone https://github.com/guelfoweb/knock.git
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/TheRook/subbrute.git
sudo snap install httpx
sudo cp subbrute Tools -r
sudo rm subbrute -r
sudo cp knock Tools -r
sudo cp SecLists Tools -r 
sudo rm SecLists -r
sudo rm knock -r
snap install amass
sudo go install -v github.com/tomnomnom/anew@latest && sudo cp /root/go/bin/anew /usr/bin/
sudo go install -v github.com/tomnomnom/httprobe@latest &&sudo  cp /root/go/bin/httprobe /usr/bin/
sudo go install -v github.com/sensepost/gowitness@latest  && sudo  cp /root/go/bin/gowitness /usr/bin/
sudo apt-get install python-dnspython 
sudo go install -v github.com/tomnomnom/waybackurls@latest && sudo sudo  cp /root/go/bin/waybackurls /usr/bin/
sudo go install -v github.com/lc/gau/v2/cmd/gau@latest && sudo sudo  cp /root/go/bin/gau /usr/bin/
