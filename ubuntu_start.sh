#!/bin/bash

#####
# 1. Update and upgrade OS and applications. 
#####
echo 'Updating OS and Applications...'
sudo apt -qq update
sudo apt -qq -y upgrade
sudo apt -qq -y autoremove

# Install curl & wget
sudo apt -y install curl wget

# To use exFAT formatted SD(or MicroSD) cards
sudo apt -y install exfat-fuse exfat-utils

# Install Git
sudo apt -y install git

# Configuration for Git
git config --global user.name "Yungon Park"
git config --global user.email "hahafree12@gmail.com"

#####
# 2. Register additional repositories
#####

# Touchpad-indicator
sudo add-apt-repository ppa:atareao/atareao

# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Docker
sudo apt -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   edge"

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
# 4. Install Programming Tools
#####

# build-essential (gcc, gdb...)
sudo apt -y install build-essential

# Install Java (OpenJDK)
sudo apt -y install openjdk-8-jdk

# Install pyenv & Python 3.7
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

# Install pyenv 3.7
pyenv install 3.7.0

# Use Python 3.7.0 as default version of Python on executing bash
echo 'export PYENV_VERSION="3.7.0"' >> ~/.bashrc

# Install nvm & Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

nvm install node
nvm install stable

# Install ruby and jekyll
sudo apt -y install ruby-full
sudo gem install jekyll bundler

# Install gvm (Golang)
sudo apt -y install mercurial make binutils bison gcc
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

source ~/.bashrc

# -B means installing golang from binary source
gvm install go1.11.1 -B

# Editors (vim & VSCode)
sudo apt -y install vim code

# Install Docker
sudo apt -y install docker-ce

#####
# 5. Install Tools for Productivity & Multimedia
#####

# Touchpad-indicator
sudo apt -y install touchpad-indicator

# Install GIMP & InkScape
sudo apt -y install gimp inkscape

# Install Restricted extras & SMPlayer
sudo apt -y install ubuntu-restricted-extras smplayer

#####
# 6. Install Database
#####

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

#####
# 7. Install Tools for Cloud Services
#####

# Install Heroku
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install AWS CLI
sudo apt -y install awscli

#####
# 8. Make script & Edit alias configuration
#####

# Make alias to move to parent directories.
echo '# Alias to move to parent directories.' >> ~/.bashrc
echo 'alias ..="cd .."' >> ~/.bashrc
echo 'alias ...="cd ../.."' >> ~/.bashrc
echo 'alias ....="cd ../../.."' >> ~/.bashrc
echo 'alias .....="cd ../../../.."' >> ~/.bashrc
echo 'alias ......="cd ../../../../.."' >> ~/.bashrc

source ~/.bashrc

# Make update script.
echo '#!/bin/bash' > ~/update.sh
echo 'sudo apt -qq update' >> ~/update.sh
echo 'sudo apt -qq -y upgrade' >> ~/update.sh
echo 'sudo apt -qq -y autoremove' >> ~/update.sh
echo 'sudo apt -qq autoclean' >> ~/update.sh
echo 'sudo apt -qq clean' >> ~/update.sh

chmod 755 ~/update.sh