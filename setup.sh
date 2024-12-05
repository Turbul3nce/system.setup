#!/usr/bin/env bash
# Setup VM
apt install open-vm-tools-desktop
apt install open-vm-tools

# Configure TMUX color
set -g status-bg colour240

# Configure Terminal to my liking. Node: Need to change this later!
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/<PROFILE_ID>/ background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/<PROFILE_ID>/ foreground-color '#FFFFFF'

# Install VIM-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup vim plugins
echo 
"call plug#begin()

" List your plugins here
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()" >> `/.vimrc

# Install Tools/languages/dependencies
apt install nmap 
apt install gobuster
apt install nodejs
apt install npm
apt install golang-go
go 

# Install libraries
npm install puppeteer

# Setup PKI 
sudo apt update -y && sudo apt upgrade -y && sudo apt install pcsc-tools libccid libpcsc-perl libpcsclite1 pcscd opensc opensc-pkcs11 vsmartcard-vpcd libnss3-tools -y

# Setup driver with Firefox
Figure out later

# Install Burpsuite
curl https://downloads.portswigger --ssl-verify 

# Setup Ghidra
Need to install and setup Ghidra here


# Project Discovery Tools

## Katana
sudo apt update
sudo snap refresh
sudo apt install zip curl wget git
sudo snap install golang --classic
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update 
sudo apt install google-chrome-stable

CGO_ENABLED=1 go install github.com/projectdiscovery/katana/cmd/katana@latest

## Naabu 
sudo apt install -y libpcap-dev, on Mac: brew install libpcap
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest


## Subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest


## Httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest


# Setup .bashrc
cat .bashrc.new >> ~/.bashrc 
source ~/.bashrc

#coc.vim 

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

# Use package feature to install coc.nvim

# for vim8
mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

