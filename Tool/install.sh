git clone https://github.com/guelfoweb/knock.git
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/TheRook/subbrute.git
git clone https://github.com/robre/scripthunter.git
git clone https://github.com/aboul3la/Sublist3r.git
git clone https://github.com/tomnomnom/assetfinder.git
sudo  go install -v github.com/tomnomnom/assetfinder
sudo cp /root/go/bin/assetfinder /usr/local/go/bin/
sudo snap install httpx
snap install amass
sudo apt-get install python-dnspython
sudo yum install python-argparse 
sudo apt-get install python-requests
sudo go install -v github.com/tomnomnom/anew@latest && sudo cp /root/go/bin/anew /usr/bin/
sudo go install -v github.com/tomnomnom/httprobe@latest &&sudo  cp /root/go/bin/httprobe /usr/bin/
sudo go install -v github.com/sensepost/gowitness@latest  && sudo  cp /root/go/bin/gowitness /usr/bin/
sudo go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && sudo cp /root/go/bin/subfinder /usr/bin/
sudo go install -v github.com/tomnomnom/waybackurls@latest && sudo   cp /root/go/bin/waybackurls /usr/bin/
sudo go install -v github.com/lc/gau/v2/cmd/gau@latest && sudo  cp /root/go/bin/gau /usr/bin/
sudo go install -v github.com/lc/subjs@latest && sudo cp /root/go/bin/subjs /usr/bin/
sudo go install -v github.com/hakluke/hakrawler@latest && sudo cp /root/go/bin/hakrawler /usr/bin/
sudo go install -v github.com/tomnomnom/unfurl@latest && sudo cp /root/go/bin/unfurl /usr/bin/
sudo apt install ffuf

