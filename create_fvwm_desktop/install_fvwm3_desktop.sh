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
sudo pkgin -y in python311
sudo touch /etc/modules.conf
echo "nvmm" | sudo tee -a /etc/modules.conf
echo "compat_linux" | sudo tee -a /etc/modules.conf

sudo ./services.py
./setup_home.py

# Install packages
echo "Installing fvwm3 packages"
sudo pkgin -y im fvwm3.pkg

echo "Updating Xresources in /etc/X11/xdm"
sudo cp ./xdm/Xresources /etc/X11/xdm/.
