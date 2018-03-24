XCLIP_IS_INSTALLED=$(which xclip | wc -l)

if [ $XCLIP_IS_INSTALLED -eq 1 ]; then
	sudo apt-get update
	sudo apt-get install xclip
fi

ssh-keygen -t rsa -C "fabioaromanini@gmail.com" -b 4096

echo "# Github 
Host github.com
  Hostname ssh.github.com
  Port 443" >> ~/.ssh/config

ssh-add ~/.ssh/id_rsa

xclip -sel clip < ~/.ssh/id_rsa.pub
