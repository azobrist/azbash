#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "Must run script as root" 2>&1
	exit 1
fi

user=$(id -u -n 1000)
home=$(pwd)
repo=/home/$user/azbash

mkdir -p /home/$user/.config
mkdir -p /home/$user/.config/kitty

apt update
apt upgrade -y

# Instal essential programs
apt install -y curl wget unzip build-essential avahi-daemon

curl -sS https://starship.rs/install.sh|sh

mv /home/$user/.bashrc $repo/bashrc.bkp

ln -svf $repo/.bashrc /home/$user/.bashrc
ln -svf $repo/starship.toml /home/$user/.config/starship.toml
ln -svf $repo/kitty.conf /home/$user/config/kitty/kitty.conf

ln -svf $repo/.gitconfig /home/$user/.gitconfig

chown -R $user:$user /home/$user/.config
chown $user:$user /home/$user/.bashrc
chown $user:$user /home/$user/.gitconfig

read -p "Enter git username: " gituser
read -p "Enter git email: " gitemail

git config --global user.name $gituser
git config --global user.email $gitemail

#apt install fontconfig
#mkdir -p /home/$user/.fonts
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
#unzip FiraCode.zip -d /home/$user/.fonts
#chown $user:$user /home/$user/.fonts/*
#fc-cache -vf
#rm ./FiraCode.zip
