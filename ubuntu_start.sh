#!/bin/bash

#####
# 1. Update and upgrade OS and applications. 
#####
echo 'Updating OS and Applications...'
sudo apt update > /dev/null
sudo apt -y upgrade > /dev/null
sudo apt -y autoremove > /dev/null

# Install curl & wget
sudo apt -y install curl wget

# To use exFAT formatted SD(or MicroSD) cards
sudo apt -y install exfat-fuse exfat-utils

# Install Git
sudo apt -y install git

#####
# 2. Register additional repositories
#####

# Java
sudo add-apt-repository ppa:webupd8team/java

# Touchpad-indicator
sudo add-apt-repository ppa:atareao/atareao

# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

#####
# 3. Configuration
#####

# To set resolution of grub
sudo sed -i 's/#GRUB_GFXMODE=640x480/GRUB_GFXMODE=1024x768/' /etc/default/grub
sudo update-grub > /dev/null

# Disable avahi daemon
sudo sed -i 's/AVAHI_DAEMON_DETECT_LOCAL=1/AVAHI_DAEMON_DETECT_LOCAL=0/' /usr/lib/avahi/avahi-daemon-check-dns.sh
sudo sed -i 's/AVAHI_DAEMON_DETECT_LOCAL=1/AVAHI_DAEMON_DETECT_LOCAL=0/' /etc/default/avahi-daemon

#####
# 4. Install packages
#####

# vim
sudo apt -y install vim

# Touchpad-indicator
sudo apt -y install touchpad-indicator

# build-essential (gcc, gdb...)
sudo apt -y install build-essential

# Install Restricted extras & SMPlayer
sudo apt -y install ubuntu-restricted-extras
sudo apt -y install smplayer

# Install Java (From Oracle)
sudo apt -y install oracle-java8-installer

# Install pyenv & Python 2.7 + 3.6
# (requisitions)
sudo apt install -y make libssl-dev zlib1g-dev libbz2-dev \
		 libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
		 xz-utils tk-dev

# Install pyenv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

echo '# pyenv' >> ~/.bashrc
echo 'export PATH="/home/yungon/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

source ~/.bashrc

pyenv update

# Install pyenv 2.7, 3.6
pyenv install 2.7.11
pyenv install 3.6.2

# Install nvm & Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

nvm install node
nvm install stable

# TODO: Install Golang

# Install Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update

sudo apt -y install code

# Install MongoDB
sudo apt -y install mongodb-org
sudo service mongod start

# Install Redis
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
cd ..
rm -rf redis-stable/ redis-stable.tar.gz

# Install Heroku
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install GIMP & InkScape
sudo apt -y install gimp inkscape

# Make update script.
echo '#!/bin/bash' > ~/update.sh
echo 'sudo apt update' >> ~/update.sh
echo 'sudo apt -y upgrade' >> ~/update.sh
echo 'sudo apt -y autoremove' >> ~/update.sh
echo 'sudo apt autoclean' >> ~/update.sh
echo 'sudo apt clean' >> ~/update.sh

chmod 755 ~/update.sh

# Install ruby and jekyll
sudo apt -y install ruby-full
sudo gem install jekyll bundler

# Configuration for Git
git config --global user.name "Yungon Park"
git config --global user.email "hahafree12@gmail.com"

# Install AWS CLI
sudo apt -y install awscli

# Make alias to move to parent directories.
echo '# Alias to move to parent directories.' >> ~/.bashrc
echo 'alias ..="cd .."' >> ~/.bashrc
echo 'alias ...="cd ../.."' >> ~/.bashrc
echo 'alias ....="cd ../../.."' >> ~/.bashrc
echo 'alias .....="cd ../../../.."' >> ~/.bashrc
echo 'alias ......="cd ../../../../.."' >> ~/.bashrc

source ~/.bashrc