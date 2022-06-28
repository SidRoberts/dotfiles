#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname -- "$(realpath $0)")

HOSTNAME="virtual"
TIMEZONE="Asia/Seoul"



sudo pacman -Syu



##########
# Locale #
##########

sudo sed -i "s/^#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/" /etc/locale.gen

sudo locale-gen

sudo localectl --no-ask-password set-locale LANGUAGE="en_GB" LANG="en_GB.UTF-8"



########
# Time #
########

sudo ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

sudo hwclock --systohc

sudo timedatectl --no-ask-password set-timezone ${TIMEZONE}
sudo timedatectl --no-ask-password set-ntp 1



############
# Hostname #
############

echo ${HOSTNAME} | sudo tee /etc/hostname



########
# Bash #
########

cp ${SCRIPT_DIR}/bash/bash_aliases ~/.bash_aliases
cp ${SCRIPT_DIR}/bash/bash_profile ~/.bash_profile
cp ${SCRIPT_DIR}/bash/bashrc       ~/.bashrc



#################
# XDG User Dirs #
#################

sudo pacman -S xdg-user-dirs --noconfirm --needed

mkdir ~/.config/
mkdir ~/Code/
mkdir ~/Downloads/
mkdir ~/ISOs/
mkdir ~/Music/
mkdir ~/Pictures/
mkdir ~/Videos/
mkdir ~/VMs/

cp ${SCRIPT_DIR}/xdg-user-dirs/user-dirs.dirs   ~/.config/
cp ${SCRIPT_DIR}/xdg-user-dirs/user-dirs.locale ~/.config/

xdg-user-dirs-update



###############
# Install yay #
###############

sudo pacman -S git --noconfirm --needed

git clone https://aur.archlinux.org/yay-git.git

cd yay-git

makepkg -si



############
# X Server #
############

sudo pacman -S xorg xorg-xinit xterm --noconfirm --needed

if [ "$(systemd-detect-virt)" = "none" ]; then
    sudo pacman -S xf86-video-intel mesa --noconfirm --needed

    sudo mkdir -p /etc/X11/xorg.conf.d/

    sudo cp ${SCRIPT_DIR}/xorg/20-intel.conf          /etc/X11/xorg.conf.d/20-intel.conf
    sudo cp ${SCRIPT_DIR}/xorg/20-intel-graphics.conf /etc/X11/xorg.conf.d/20-intel-graphics.conf
else
    sudo pacman -S xf86-video-vesa --noconfirm --needed
fi

sudo pacman -S xautolock --noconfirm --needed



######
# i3 #
######

sudo pacman -S i3-gaps i3lock --noconfirm --needed

mkdir -p ~/.config/i3/

cp -r ${SCRIPT_DIR}/i3/. ~/.config/i3/



###########
# LightDM #
###########

sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed

sudo mkdir /etc/lightdm/lightdm.conf.d/

sudo cp ${SCRIPT_DIR}/dmrc/dmrc ~/.dmrc

sudo cp ${SCRIPT_DIR}/lightdm/autologin.conf /etc/lightdm/lightdm.conf.d/autologin.conf

sudo groupadd -r autologin

sudo usermod -aG autologin ${USER}

sudo gpasswd -a ${USER} autologin

sudo systemctl enable lightdm




###########
# Polybar #
###########

sudo pacman -S polybar --noconfirm --needed

cp -R ${SCRIPT_DIR}/polybar/. ~/.config/polybar/



##########
# Thunar #
##########

sudo pacman -S thunar thunar-archive-plugin thunar-volman gvfs --noconfirm --needed

mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/

cp ${SCRIPT_DIR}/thunar/thunar.xml        ~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml
cp ${SCRIPT_DIR}/thunar/thunar-volman.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar-volman.xml



#########
# picom #
#########

sudo pacman -S picom --noconfirm --needed

cp -r ${SCRIPT_DIR}/picom/. ~/.config/picom/



############
# Nitrogen #
############

sudo pacman -S nitrogen --noconfirm --needed

cp -r ${SCRIPT_DIR}/nitrogen/. ~/.config/nitrogen/

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

sudo pacman -S rofi --noconfirm --needed

mkdir -p ~/.config/rofi/

cp -r ${SCRIPT_DIR}/rofi/. ~/.config/rofi/



#########
# Dunst #
#########

sudo pacman -S dunst --noconfirm --needed

cp -r ${SCRIPT_DIR}/dunst/. ~/.config/dunst/



##############
# Networking #
##############

sudo pacman -S networkmanager network-manager-applet --noconfirm --needed

sudo systemctl enable NetworkManager



##################
# Xfce4 Terminal #
##################

sudo pacman -S xfce4-terminal --noconfirm --needed

mkdir -p ~/.config/xfce4/terminal/
mkdir -p ~/.local/share/xfce4/terminal/colorschemes/

cp ${SCRIPT_DIR}/xfce4-terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
cp ${SCRIPT_DIR}/xfce4-terminal/nord.theme ~/.local/share/xfce4/terminal/colorschemes/nord.theme



#########
# Fonts #
#########

sudo pacman -S ttf-dejavu --noconfirm --needed

# FontAwesome icons
sudo pacman -S awesome-terminal-fonts --noconfirm --needed

sudo pacman -S ttf-fira-code --noconfirm --needed

sudo pacman -S noto-fonts noto-fonts-cjk --noconfirm --needed

sudo pacman -S adobe-source-han-sans-kr-fonts adobe-source-han-serif-kr-fonts --noconfirm --needed

# Emoji
sudo pacman -S noto-fonts-emoji --noconfirm --needed



##########
# Themes #
##########

sudo pacman -S arc-gtk-theme --noconfirm --needed

yay -S qogir-icon-theme --noconfirm --needed

cp -r ${SCRIPT_DIR}/gtk/gtk-2.0/. ~/.config/gtk-2.0/
cp -r ${SCRIPT_DIR}/gtk/gtk-3.0/. ~/.config/gtk-3.0/
cp -r ${SCRIPT_DIR}/gtk/gtk-4.0/. ~/.config/gtk-4.0/



#################################
# Greenclip - clipboard manager #
#################################

yay -S rofi-greenclip --noconfirm --needed

cp ${SCRIPT_DIR}/greenclip/greenclip.toml ~/.config/greenclip.toml



###########
# Keymaps #
###########

sudo localectl --no-ask-password set-keymap uk

sudo localectl --no-ask-password set-x11-keymap gb



##############
# Audio apps #
##############

sudo pacman -S alsa-utils --noconfirm --needed

sudo pacman -S audacity --noconfirm --needed

sudo pacman -S ffmpeg --noconfirm --needed



##############
# Image apps #
##############

sudo pacman -S imagemagick --noconfirm --needed

sudo pacman -S gimp --noconfirm --needed

sudo pacman -S inkscape --noconfirm --needed



##############
# Video apps #
##############

sudo pacman -S handbrake --noconfirm --needed

sudo pacman -S mpv --noconfirm --needed

sudo pacman -S yt-dlp --noconfirm --needed



#######
# PHP #
#######

sudo pacman -S php --noconfirm --needed

yay -S php-yaml --noconfirm --needed

sudo pacman -S xdebug --noconfirm --needed

# Enable Xdebug
sudo sed -i "s/;zend_extension=xdebug.so/zend_extension=xdebug.so/g" /etc/php/conf.d/xdebug.ini

# Add coverage mode
echo "xdebug.mode=coverage" | sudo tee -a /etc/php/conf.d/xdebug.ini

sudo pacman -S composer --noconfirm --needed



##########
# Docker #
##########

sudo pacman -S docker docker-compose --noconfirm --needed

sudo usermod -aG docker ${USER}

sudo systemctl enable docker



#############
# Autotrash #
#############

yay -S autotrash --noconfirm --needed

# Make Trash folders
mkdir -p ~/.local/share/Trash/{expunged,files,info}
chmod -R 700 ~/.local/share/Trash/{expunged,files,info}

# Empty trash after 14 days
autotrash -d 14 --install



############
# Printing #
############

sudo pacman -S cups cups-pdf --noconfirm --needed

sudo cp ${SCRIPT_DIR}/cups/cups-pdf.conf /etc/cups/cups-pdf.conf

sudo systemctl enable cups



###########################
# Disable internal webcam #
###########################

# Only disable this USB device if it's an integrated webcam
if grep -q "Laptop_Integrated_Webcam_1.3M" /sys/bus/usb/devices/1-1.5/product; then
    echo 0 | sudo tee /sys/bus/usb/devices/1-1.5/bConfigurationValue
fi




##############
# OBS Studio #
##############

sudo pacman -S obs-studio --noconfirm --needed



###########
# SSH key #
###########

ssh-keygen -t ed25519 -C "sid@sidroberts.co.uk" -f ~/.ssh/id_ed25519 -N ""

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519



#######
# Git #
#######

sudo pacman -S git --noconfirm --needed

cp ${SCRIPT_DIR}/git/gitconfig ~/.gitconfig



########
# Zoom #
########

yay -S zoom --noconfirm --needed



#################
# XP Pen tablet #
#################

yay -S xp-pen-tablet  --noconfirm --needed



########
# nano #
########

sudo pacman -S nano nano-syntax-highlighting --noconfirm --needed

cp nano/nanorc ~/.nanorc



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
    sudo pacman -S virtualbox --noconfirm --needed

    vboxmanage setproperty machinefolder ~/VMs
fi



##########################
# VirtualBox guest utils #
##########################

# Only install within a VM
if [ -e /dev/vboxguest ]; then
    sudo pacman -S virtualbox-guest-utils --noconfirm --needed

    sudo systemctl enable vboxservice
fi



###########
# VS Code #
###########

sudo pacman -S code --noconfirm --needed

mkdir -p "~/.config/Code - OSS/"
mkdir -p "~/.config/Code - OSS/User/"

cp vs-code/Preferences   "~/.config/Code - OSS/Preferences"
cp vs-code/settings.json "~/.config/Code - OSS/User/settings.json"



#######################################
# Projecteur - for Logitech Spotlight #
#######################################

yay -S projecteur-git --noconfirm --needed

mkdir ~/.config/Projecteur

cp projecteur/Projecteur.conf ~/.config/Projecteur/Projecteur.conf



########
# Misc #
########

sudo pacman -S acpi wireless_tools --noconfirm --needed

sudo pacman -S tldr --noconfirm --needed

sudo pacman -S arandr --noconfirm --needed

sudo pacman -S playerctl --noconfirm --needed

sudo pacman -S transmission-gtk --noconfirm --needed

sudo pacman -S gparted --noconfirm --needed

sudo pacman -S scrot --noconfirm --needed

yay -S google-chrome --noconfirm --needed

yay -S postman-bin --noconfirm --needed

sudo pacman -S rclone --noconfirm --needed

sudo pacman -S rsync --noconfirm --needed

yay -S ngrok --noconfirm --needed

sudo pacman -S meld --noconfirm --needed



##################
# Add to-do list #
##################

cp ${SCRIPT_DIR}/ToDoList.md ~/



################
# Copy scripts #
################

cp -r ${SCRIPT_DIR}/scripts/. ~/scripts/



##########
# Reboot #
##########

systemctl reboot
