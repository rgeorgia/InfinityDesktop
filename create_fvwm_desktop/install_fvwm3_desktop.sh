#!/bin/sh
#
BASE_DIR=$PWD
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

FILE=/etc/modules.conf
if [ ! -f "$FILE" ]; then
  echo "Creating ${FILE}"
  sudo touch /etc/modules.conf
fi

grep "nvmm" $FILE
if [ ! $? = 0 ]
then
    echo "Adding nvmm to ${FILE}"
    echo "nvmm" | sudo tee -a /etc/modules.conf
fi

grep "compat_linux" $FILE
if [ ! $? = 0 ]
then
    echo "Adding compat_linux to ${FILE}"
    echo "compat_linux" | sudo tee -a /etc/modules.conf
fi

./install_infinity.py

# Install packages
echo "Installing fvwm3 packages"
sudo pkgin -y im packages/fvwm3.pkg

echo "Updating Xresources in /etc/X11/xdm"
sudo cp ./xdm/Xresources /etc/X11/xdm/.
cd $HOME
ln -s .xinitrc .xsession
cd ${PWD}
