#!/usr/pkg/bin/python3.11

"""

chsh -s /usr/pkg/bin/fish

# Make .fvwm
mkdir -p $HOME/.fvwm
cp -r dot-fvwm/fvwm/* $HOME/.fvwm
"""
import shutil
import subprocess
from pathlib import Path


class SetupHome:
    def __init__(self):
        self.dot_file_location = Path(".").joinpath("dot-files")
        self.dot_fvwm_location = Path(".").joinpath("dot-fvwm")
        self.dirs_to_create = ['Documents', 'Downloads', 'Templates', 'Videos', 'Pictures/backgrounds', 'Nowhere', ]

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

    def make_dot_fvwm(self):
        pass


class UserConfig:
    def __init__(self):
        self.dot_config_location = Path(".").joinpath("dot-config")
        self.dot_config_dirs = ['fish', 'sakura', 'fvwm3']

    @staticmethod
    def change_to_fish():
        subprocess.run("chsh -s /usr/pkg/bin/fish", shell=True)

    def setup_dot_config(self):
        """
        cp -r dot-config/fish/* $HOME/.config/fish/.
        cp -r dot-config/sakura/* $HOME/.config/sakura/.
        cp -r dot-config/fvwm3/* $HOME/.config/fvwm3/.
        :return:
        """
        for item in self.dot_config_dirs:
            new_dir = Path.home().joinpath(".config").joinpath(item)
            new_dir.mkdir(parents=True, exist_ok=True)
            """
             shutil.copytree(src, dst, 
             symlinks=False, 
             ignore=None, 
             copy_function=copy2, 
             ignore_dangling_symlinks=False, dirs_exist_ok=False)¶
            """
            shutil.copytree(self.dot_config_location, new_dir)

    @staticmethod
    def symlink_initrc():
        # create symlink from .xinitrc to .xsession
        src = Path.home().joinpath(".xinitrc")
        target = Path.home().joinpath(".xsession")
        src.symlink_to(str(target))


def main():
    set_up_home = SetupHome()
    user_config = UserConfig()
    set_up_home.copy_dot_files()
    user_config.symlink_initrc()
    set_up_home.make_home()
    set_up_home.make_dot_fvwm()
    user_config.setup_dot_config()
    set_up_home.make_dot_fvwm()
    user_config.change_to_fish()


if __name__ == "__main__":
    main()
