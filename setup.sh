#!/usr/bin/env bash

set -e



echo "==============================="
echo "= Sid's Fedora Install Script ="
echo "==============================="
echo
echo "If you are not me, then you probably shouldn't be running this! ;)"
echo
echo "The setup will begin in 5 seconds. Ctrl+C to cancel."
echo
echo -n "5 seconds... "
sleep 1
echo -n "4 seconds... "
sleep 1
echo -n "3 seconds... "
sleep 1
echo -n "2 seconds... "
sleep 1
echo -n "1 second... "
sleep 1
echo "Starting now."



SCRIPT_DIR=$(dirname -- "$(realpath $0)")



sudo dnf -y upgrade



##############
# RPM Fusion #
#############

sudo dnf -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm



########
# GRUB #
########

sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

sudo grub2-mkconfig -o /etc/grub2.cfg
sudo grub2-mkconfig -o /etc/grub2-efi.cfg



########
# Bash #
########

cp ${SCRIPT_DIR}/bash/bash_aliases ~/.bash_aliases
cp ${SCRIPT_DIR}/bash/bash_profile ~/.bash_profile
cp ${SCRIPT_DIR}/bash/bashrc       ~/.bashrc



#################
# XDG User Dirs #
#################

mkdir ~/bin/
mkdir ~/Code/
mkdir ~/ISOs/
mkdir ~/VMs/

rm -r ~/Desktop/
rm -r ~/Documents/
rm -r ~/Templates/

cp ${SCRIPT_DIR}/xdg-user-dirs/user-dirs.dirs ~/.config/

xdg-user-dirs-update



######
# i3 #
######

mkdir -p ~/.config/i3/

cp -R ${SCRIPT_DIR}/i3/. ~/.config/i3/



#############
# Autologin #
#############

sudo cp ${SCRIPT_DIR}/lightdm/autologin.conf /etc/lightdm/lightdm.conf.d/autologin.conf

sudo groupadd -r autologin

sudo usermod -aG autologin ${USER}

sudo gpasswd -a ${USER} autologin



###########
# Polybar #
###########

sudo dnf -y install https://dl.fedoraproject.org/pub/fedora/linux/updates/testing/39/Everything/x86_64/Packages/p/polybar-3.7.0-1.fc39.x86_64.rpm

cp -R ${SCRIPT_DIR}/polybar/. ~/.config/polybar/



##########
# Thunar #
##########

sudo dnf -y install thunar-archive-plugin thunar-volman

cp ${SCRIPT_DIR}/thunar/thunar.xml        ~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml
cp ${SCRIPT_DIR}/thunar/thunar-volman.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar-volman.xml



#########
# picom #
#########

sudo dnf -y install picom

cp -R ${SCRIPT_DIR}/picom/. ~/.config/picom/



############
# Nitrogen #
############

sudo dnf -y install nitrogen

cp -R ${SCRIPT_DIR}/nitrogen/. ~/.config/nitrogen/

backgrounds=(
    "https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg"
    "https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg"
    "https://images.pexels.com/photos/1631677/pexels-photo-1631677.jpeg"
    "https://images.pexels.com/photos/310452/pexels-photo-310452.jpeg"
)

mkdir ~/Pictures/Backgrounds

cd ~/Pictures/Backgrounds

for url in ${backgrounds[@]}; do
    curl -O ${url}
done



########
# Rofi #
########

sudo dnf -y install rofi

cp -R ${SCRIPT_DIR}/rofi/. ~/.config/rofi/



#########
# Dunst #
#########

cp -R ${SCRIPT_DIR}/dunst/. ~/.config/dunst/



##################
# Xfce4 Terminal #
##################

mkdir -p ~/.config/xfce4/terminal/
mkdir -p ~/.local/share/xfce4/terminal/colorschemes/

cp ${SCRIPT_DIR}/xfce4-terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
cp ${SCRIPT_DIR}/xfce4-terminal/nord.theme ~/.local/share/xfce4/terminal/colorschemes/nord.theme



#########
# Fonts #
#########

sudo dnf -y install google-noto-sans-fonts google-noto-serif-fonts

sudo dnf -y install dejavu-fonts-all

sudo dnf -y install fira-code-fonts

# Korean fonts
sudo dnf -y install google-noto-sans-cjk-fonts google-noto-serif-cjk-fonts adobe-source-han-sans-kr-fonts adobe-source-han-serif-kr-fonts

# FontAwesome icons
wget https://github.com/gabrielelana/awesome-terminal-fonts/archive/refs/heads/master.zip
unzip master.zip
cd awesome-terminal-fonts-master/
cp -R build/. ~/.fonts/
fc-cache -fv ~/.fonts/

# Emoji
sudo dnf -y install google-noto-emoji-fonts



##########
# Themes #
##########

sudo dnf -y install arc-theme

wget https://github.com/vinceliuice/Qogir-theme/archive/refs/heads/master.zip
unzip master.zip
cd Qogir-theme-master/
./install.sh

cp -R ${SCRIPT_DIR}/gtk/gtk-2.0/. ~/.config/gtk-2.0/
cp -R ${SCRIPT_DIR}/gtk/gtk-3.0/. ~/.config/gtk-3.0/
cp -R ${SCRIPT_DIR}/gtk/gtk-4.0/. ~/.config/gtk-4.0/



#################################
# Greenclip - clipboard manager #
#################################

wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O ~/bin/greenclip

chmod +x ~/bin/greenclip

cp ${SCRIPT_DIR}/greenclip/greenclip.toml ~/.config/greenclip.toml



##############
# Audio apps #
##############

sudo dnf -y install audacity

sudo dnf -y install ffmpeg --allowerasing



##############
# Image apps #
##############

sudo dnf -y install inkscape



########
# GIMP #
########

sudo dnf -y install gimp

mkdir -p ~/.config/GIMP/2.10/

cp ${SCRIPT_DIR}/gimp/gimprc ~/.config/GIMP/2.10/gimprc



##############
# Video apps #
##############

sudo dnf -y install handbrake

sudo dnf -y install yt-dlp



#######
# mpv #
#######

sudo dnf -y install mpv

mkdir -p ~/.config/mpv/

cp ${SCRIPT_DIR}/mpv/mpv.conf ~/.config/mpv/mpv.conf



#######
# PHP #
#######

sudo dnf -y install php

sudo dnf -y install php-devel php-pear libyaml-devel

printf "\n" | sudo pecl install yaml

sudo dnf -y install php-pecl-xdebug3

echo "extension=yaml.so" | sudo tee /etc/php.d/50-yaml.ini

# Add coverage mode
sudo sed -i 's/;xdebug.mode = develop/xdebug.mode = coverage/g' /etc/php.d/15-xdebug.ini

sudo dnf -y install composer



##############
# Node / NPM #
##############

sudo dnf -y install nodejs nodejs-npm



##########
# Docker #
##########

sudo dnf -y install docker docker-compose

sudo dnf -y install https://kojipkgs.fedoraproject.org/packages/containerd/1.6.19/1.fc39/x86_64/containerd-1.6.19-1.fc39.x86_64.rpm

sudo dnf -y install 'dnf-command(versionlock)'

sudo dnf versionlock containerd

sudo usermod -aG docker ${USER}

sudo systemctl enable docker

#TODO bash ${SCRIPT_DIR}/scripts/docker-pull.sh



#############
# Autotrash #
#############

sudo dnf -y install pipx

pipx install autotrash

# Make Trash folders
mkdir -p ~/.local/share/Trash/{expunged,files,info}
chmod -R 700 ~/.local/share/Trash/{expunged,files,info}

autotrash -d 14 --install



###################
# Printing to PDF #
###################

sudo dnf -y install cups-pdf

sudo cp ${SCRIPT_DIR}/cups/cups-pdf.conf /etc/cups/cups-pdf.conf



###########################
# Disable internal webcam #
###########################

# Only disable this USB device if it's an integrated webcam
if grep -q "Laptop_Integrated_Webcam_1.3M" /sys/bus/usb/devices/2-1.5/product; then
    echo 0 | sudo tee /sys/bus/usb/devices/2-1.5/bConfigurationValue
fi



##############
# OBS Studio #
##############

sudo dnf -y install obs-studio



###########
# SSH key #
###########

ssh-keygen -t ed25519 -C "sid@sidroberts.co.uk" -f ~/.ssh/id_ed25519 -N ""

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519



#######
# Git #
#######

sudo dnf -y install git

cp ${SCRIPT_DIR}/git/gitconfig ~/.gitconfig



########
# Zoom #
########

sudo dnf -y install https://zoom.us/client/5.16.6.382/zoom_x86_64.rpm



#################
# XP Pen tablet #
#################

curl "https://www.xp-pen.com/download/file.html?id=1948&pid=430&ext=rpm" --output /tmp/xp-pen.rpm

sudo dnf -y install /tmp/xp-pen.rpm



########
# nano #
########

cp ${SCRIPT_DIR}/nano/nanorc ~/.nanorc



##############
# MIME types #
##############

cp ${SCRIPT_DIR}/mime/mimeapps.list ~/.config/mimeapps.list



####################
# GTK File Chooser #
####################

gsettings set org.gtk.Settings.FileChooser sort-directories-first true



##############
# VirtualBox #
##############

# Only install on bare metal
if [ ! -e /dev/vboxguest ]; then
    sudo dnf -y install virtualbox

    vboxmanage setproperty machinefolder ~/VMs
fi



##########################
# VirtualBox guest utils #
##########################

# Only install within a VM
if [ -e /dev/vboxguest ]; then
    sudo dnf -y install virtualbox-guest-additions
fi



###########
# VS Code #
###########

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo cp ${SCRIPT_DIR}/vs-code/vscode.repo /etc/yum.repos.d/vscode.repo

sudo dnf -y install code

mkdir -p ~/.config/Code/
mkdir -p ~/.config/Code/User/

cp ${SCRIPT_DIR}/vs-code/Preferences   ~/.config/Code/Preferences
cp ${SCRIPT_DIR}/vs-code/settings.json ~/.config/Code/User/settings.json

# SASS extension
code --install-extension syler.sass-indented

# Node color scheme
code --install-extension arcticicestudio.nord-visual-studio-code



#######################################
# Projecteur - for Logitech Spotlight #
#######################################

sudo dnf -y install https://github.com/jahnf/Projecteur/releases/download/v0.10/projecteur-0.10_fedora-38-x86_64.rpm

mkdir ~/.config/Projecteur

cp ${SCRIPT_DIR}/projecteur/Projecteur.conf ~/.config/Projecteur/Projecteur.conf



########
# Misc #
########

sudo dnf -y install tldr

sudo dnf -y install playerctl

sudo dnf -y install transmission-gtk

sudo dnf -y install gparted

sudo dnf -y install scrot

sudo dnf -y install rclone

sudo dnf -y install meld



######################
# Stuff I don't need #
######################

sudo dnf -y remove azote

sudo dnf -y remove mousepad



##################
# Add to-do list #
##################

cp ${SCRIPT_DIR}/ToDoList.md ~/



################
# Copy scripts #
################

cp -R ${SCRIPT_DIR}/scripts/. ~/Scripts/



##########
# Reboot #
##########

systemctl reboot
