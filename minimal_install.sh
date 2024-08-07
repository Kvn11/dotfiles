#!/usr/bin/bash

current_user="$USER"
mkdir -p ~/.config
mkdir -p ~/.config/alacritty

sudo apt update
sudo apt install -y \
curl wget \
git \
python3 python3-pip \
zsh \
vim \
tmux \
unzip

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set path variable:
echo 'PATH=$PATH:/usr/local/go/bin:/home/$current_user/.local/bin' >> ~/.zshrc

# Change default shell to zsh
sudo chsh -s /bin/zsh

# Install python3 virtual environments
python3 -m pip install virtualenv

# Install vscode
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

# Install alacritty
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update
sudo apt install -y alacritty

# Set up ssh keys
ssh-keygen -f ~/.ssh/id_rsa
eval "$(ssh-agent -s)"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install golang
cd /home/$current_user/Downloads
wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin:/home/$current_user/.local/bin

# Install FiracodeFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip -O ~/Downloads/FiraCode.zip
sudo mkdir -p /usr/local/share/fonts/FiraCode && sudo unzip /home/$current_user/Downloads/FiraCode.zip -d /usr/local/share/fonts/FiraCode/
fc-cache -f -v

# Install starship terminal
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Set theme to custom dracula:
wget https://raw.githubusercontent.com/Kvn11/dotfiles/master/alacritty/alacritty.toml -O ~/.config/alacritty/alacritty.toml
