#!/bin/sh
#

id | egrep "wheel|root" > /dev/null 2>&1
if [ $? = 0 ]
then
    echo "You have permission"
else
    echo "You do not have root level permission"
    exit 1
fi

# Update /etc/rc.conf file
./services.py

### End services and update rc.conf

# Makes home
# copy dot files
cp dot-files/dot-Xresources $HOME/.Xresources
cp dot-files/dot-gitconfig $HOME/.gitconfig
cp dot-files/dot-vimrc $HOME/.vimrc
cp dot-files/dot-tcshrc $HOME/.tcshrc
cp dot-files/dot-xinitrc $HOME/.xinitrc
cp dot-files/dot-xprofile $HOME/.xprofile
ln $HOME/.xinitrc $HOME/.xsession

# Make Home
mkdir -p $HOME/Document $HOME/Downloads $HOME/Templates $HOME/Videos $HOME/Pictures/backgrounds $HOME/Nowhere

# Make .config
mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/sakura
mkdir -p $HOME/.config/fvwm3
cp -r dot-config/fish/* $HOME/.config/fish/.
cp -r dot-config/sakura/* $HOME/.config/sakura/.
cp -r dot-config/fvwm3/* $HOME/.config/fvwm3/.

chsh -s /usr/pkg/bin/fish

# Make .fvwm
mkdir -p $HOME/.fvwm
cp -r dot-fvwm/fvwm/* $HOME/.fvwm

# Install packages
echo "Installing fvwm3 packages"
sudo pkgin -y im fvwm3.pkg
echo "Installing Fonts"
sudo pkgin -y im fonts.pkg
echo "Installing Misc pagkages"
sudo pkgin -y im misc.pkg
echo "Installing Fonts"
sudo pkgin -y im fonts.pkg
echo "Installing Development packages"
sudo pkgin -y im devlop.pkg

sudo cp ./xdm/Xresources /etc/X11/xdm/.
