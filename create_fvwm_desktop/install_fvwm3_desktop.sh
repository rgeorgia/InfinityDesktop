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

### Install services and update rc.conf

EXAMPLE_RCD=/usr/pkg/share/examples/rc.d
ETC_RCD=/etc/rc.d

install_services()
    for x in dbus hal avahi fam
    do
        sudo pkgin -y in ${x}
    done


# copy service files to /etc/rc.d
copy_to_rcd()
    for x in dbus hal avahidaemon famd
    do
        sudo cp $EXAMPLE_RCD/$x $ETC_RCD/$x
    done

install_services
copy_to_rcd

# Added services to rc.conf then start them.
# MAKE SURE YOU HAVE THE -a FLAG OTHERWISE YOU'LL OVERWRITE THE rc.conf FILE
# Make a copy for "just in case"
cp /etc/rc.conf /tmp/rc.conf.bk

for x in dbus avahidaemon rpcbind famd hal
do
	grep $x /etc/rc.conf
	if [ $? -eq 1 ]
	then
		echo "${x}=YES" | sudo tee -a /etc/rc.conf
		sudo service $x start
	else
		echo "${x} is already in rc.conf"
		sudo service $x restart
	fi
done

echo "xdm=YES" | sudo tee -a /etc/rc.conf

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
