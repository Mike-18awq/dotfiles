# Download programs
sudo pacman -S noto-fonts
sudo pacman -S --needed $(cat programs.txt)

# Generate directories
xdg-user-dirs-update

# Create directories
mkdir -p ~/.config/ && cp -r config/* ~/.config/
mkdir -p ~/.cache/ && cp -r cache/* ~/.cache/
mkdir -p ~/.fonts/
mkdir -p ~/.icons/
mkdir -p ~/.themes/
mkdir -p ~/.GTK-configs/

# Set Icons
tar -xf icons.tar.gz
mv -f .icons/* ~/.icons/

# Set Themes
tar -xf themes.tar.gz
mv -f .themes/* ~/.themes/

# Set Wallpapers
#tar -xf Wallpapers.tar.gz && cp -r Wallpapers/ "$(xdg-user-dir PICTURES)"
mkdir -p "$(xdg-user-dir PICTURES)"/Wallpapers
#mv -f Wallpapers/* "$(xdg-user-dir PICTURES)"/Wallpapers/
cp -r Wallpapers/* "$(xdg-user-dir PICTURES)"/Wallpapers/

# Scripts for change theme
cp -r GTK-configs/* ~/.GTK-configs/

# .xsettingsd config
cp xsettingsd ~/.xsettingsd

# wal --set
cp aliases ~/.aliases

# Walogram (Telegram theme)
cd ~/ && git clone https://codeberg.org/thirtysixpw/walogram
sleep 2
cp constantsTelegram.tdesktop-theme ~/walogram/constants.tdesktop-theme
cd ~/walogram/ && sudo make install

# Download Pywal
pip install PyGObject --break-system-packages
pip install pywal --break-system-packages

# Path
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
echo 'source $HOME/.aliases' >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
echo 'source $HOME/.aliases' >> ~/.zshrc
sleep 1
source ~/.bashrc
source ~/.zshrc

# bpytop theme (symbolic link)
mkdir -p ~/.config/bpytop/themes/ && ln -s ~/.cache/wal/bpytopPywal.theme ~/.config/bpytop/themes/bpytopPywal.theme

# dunst theme (symbolic link)
mkdir -p ~/.config/dunst/ && ln -s ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
wal --theme Dracula

# Oomox install (themes GTK generator)
# Si quieres generar tus propios temas  GTKcon oomox descomentar las 3 lineas siguientes
#cd ~/ && git clone https://github.com/themix-project/oomox.git --recursive
#cd ~/oomox && make -f po.mk install
#mv ~/oomox/ ~/.oomox
#Es muy pesado por eso si no quieres generar tus temas entonces no lo instales

# Execution permissions
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/*.sh
chmod +x ~/.config/polybar/*.sh
chmod -R +x ~/.GTK-configs/*.sh

# GTK y qt
cd ~/ && git clone https://aur.archlinux.org/qt5-styleplugins.git && cd ~/qt5-styleplugins && makepkg -si
cd ~/ && git clone https://aur.archlinux.org/qt6gtk2.git && cd ~/qt6gtk2 && makepkg -si

# Java Problems
echo '_JAVA_AWT_WM_NONREPARENTING=1' | sudo tee -a /etc/environment

# GTK theme for Qt
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

# Ly Display Manager theme
sudo chmod 0777 /lib/systemd/system/ly.service
# Set Ly Display manager default
systemctl enable ly.service

# Set terminal default in Gnome and Cinnamon
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/alacritty

# Volume initialize in 100%
pactl set-sink-volume @DEFAULT_SINK@ 100%

# Set colors all
~/.GTK-configs/Nord.sh

# neovim - nvChad
mkdir -p ~/.config/nvim
rm -rf ~/.config/nvim/*
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
