echo "Make sure you have sudo permissions."

# Install and start services
INSTALL_FILE=services.pkg
sudo pkgin -y im ${INSTALL_FILE}

# copy service files to /etc/rc.d
EXAMPLE_RCD=/usr/pkg/share/examples/rc.d
ETC_RCD=/etc/rc.d
for x in dbus hal avahidaemon famd
do
	sudo cp $EXAMPLE_RCD/$x $ETC_RCD/$x
done

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
echo "Installing package"
sudo pkgin -y im fvwm3.pkg

sudo cp ./xdm/Xresources /etc/X11/xdm/.
