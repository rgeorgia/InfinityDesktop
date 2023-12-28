#!/usr/pkg/bin/python3.11

# Makes home
# copy dot files
# Make Home
# Make .config
# change shell to fish
# Make .fvwm

"""
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
"""


def copy_dot_files():
    pass


def make_home():
    pass


def setup_dot_config():
    pass


def chsh_fish():
    # maybe make this interactive?
    pass


def make_dot_fvwm():
    pass
