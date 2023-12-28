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
import shutil
from pathlib import Path


class SetupHome:
    def __init__(self):
        self.dot_file_location = Path(".").joinpath("dot-files")
        self.dot_fvwm_location = Path(".").joinpath("dot-fvwm")

    def copy_dot_files(self):
        for item in self.dot_file_location.iterdir():
            target_file_name = str(item).split("/")[1].replace("dot-", ".")
            source_file_name = str(item)
            print(f"Copyting {source_file_name} to {Path.home().joinpath(target_file_name)}")
            # shutil.copy2(source_file_name, target_file_name)

    def make_home(self):
        pass

    def setup_dot_config(self):
        pass

    def make_dot_fvwm(self):
        pass

    def symlink_initrc(self):
        pass


class UserConfig:
    def __init__(self):
        self.dot_config_location = Path(".").joinpath("dot-config")

    def change_to_fish(self):
        pass

    def setup_dot_config(self):
        pass


if __name__ == "__main__":
    set_up_home = SetupHome()
    set_up_home.copy_dot_files()