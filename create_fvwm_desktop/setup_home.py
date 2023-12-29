#!/usr/pkg/bin/python3.11

"""
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
        self.dot_config_location = Path(".").joinpath("dot-config")
        self.dirs_to_create = ['Documents', 'Downloads', 'Templates', 'Videos', 'Pictures/backgrounds', 'Nowhere', ]
        self.dot_config_dirs = ['fish', 'sakura', 'fvwm3']

    def copy_dot_files(self):
        for item in self.dot_file_location.iterdir():
            target_file_name = str(item).split("/")[1].replace("dot-", ".")
            source_file_name = str(item)
            print(f"Copying {source_file_name} to {Path.home().joinpath(target_file_name)}")
            shutil.copy2(source_file_name, target_file_name)

    def make_home(self):
        for item in self.dirs_to_create:
            new_dir = Path.home().joinpath(item)
            new_dir.mkdir(parents=True, exist_ok=True)

    def make_dot_config(self):
        """
        cp -r dot-config/fish/* $HOME/.config/fish/.
        cp -r dot-config/sakura/* $HOME/.config/sakura/.
        cp -r dot-config/fvwm3/* $HOME/.config/fvwm3/.
        :return:
        """
        for item in self.dot_config_dirs:
            new_dir = Path.home().joinpath(".config").joinpath(item)
            new_dir.mkdir(parents=True, exist_ok=True)

    def make_dot_fvwm(self):
        pass

    @staticmethod
    def symlink_initrc():
        # create symlink from .xinitrc to .xsession
        src = Path.home().joinpath(".xinitrc")
        target = Path.home().joinpath(".xsession")
        src.symlink_to(str(target))


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
    set_up_home.make_home()
