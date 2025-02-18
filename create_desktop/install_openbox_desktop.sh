#!/bin/sh
#
echo "INSTALLING Openbox Desktop ENV"
BASE_DIR=$PWD
id | egrep "wheel|root" > /dev/null 2>&1
if [ $? = 0 ]
then
    echo "You have permission"
else
    echo "You do not have root level permission"
    exit 1
fi

# Make sure python3.13 is installed
doas pkgin -y in python313
doas pkgin -y in gh

FILE=/etc/modules.conf
if [ ! -f "$FILE" ]; then
  echo "Creating ${FILE}"
  doas touch /etc/modules.conf
fi

grep "nvmm" $FILE
if [ ! $? = 0 ]
then
    echo "Adding nvmm to ${FILE}"
    echo "nvmm" | doas tee -a /etc/modules.conf
fi

grep "compat_linux" $FILE
if [ ! $? = 0 ]
then
    echo "Adding compat_linux to ${FILE}"
    echo "compat_linux" | doas tee -a /etc/modules.conf
fi

./install_infinity.py

# Install packages
echo "Installing openbox packages"
doas pkgin -y im packages/openbox-full.pkg

echo "Updating Xresources in /etc/X11/xdm"
doas cp ./xdm/Xresources /etc/X11/xdm/.
cd $HOME
ln -s .xinitrc .xsession
cd ${PWD}
