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

# Make sure python3.11 is installed
sudo pkgin in python311

# Update /etc/rc.conf file
sudo ./services.py

./setup_home.py

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
