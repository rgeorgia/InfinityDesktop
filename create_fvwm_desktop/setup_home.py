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
        self.dot_fvwm_location = Path(".").joinpath("dot-fvwm").joinpath("fvwm")
        self.dirs_to_create = ['Documents', 'Downloads', 'Templates', 'Videos', 'Pictures/backgrounds', 'Nowhere', ]

    def copy_dot_files(self):
        for item in self.dot_file_location.iterdir():
            target_file_name = str(item).split("/")[1].replace("dot-", ".")
            source_file_name = str(item)
            print(f"Copying {source_file_name} to {Path.home().joinpath(target_file_name)}")
            shutil.copy(source_file_name, Path.home().joinpath(target_file_name))

    def make_home(self):
        for item in self.dirs_to_create:
            new_dir = Path.home().joinpath(item)
            new_dir.mkdir(parents=True, exist_ok=True)

    def make_dot_fvwm(self):
        print(f"Copying {self.dot_fvwm_location} to {Path.home().joinpath('.fvwm')}")
        shutil.copytree(self.dot_fvwm_location, Path.home().joinpath(".fvwm"), symlinks=False, ignore=None,
                        copy_function=shutil.copy2, ignore_dangling_symlinks=False, dirs_exist_ok=True)


class UserConfig:
    def __init__(self):
        self.dot_config_location = Path(".").joinpath("dot-config")
        self.dot_config_dirs = ['fish', 'sakura', 'fvwm3']

    @staticmethod
    def change_to_fish():
        print("Changing shell to fish")
        subprocess.run("chsh -s /usr/pkg/bin/fish", shell=True)

    def setup_dot_config(self):
        """

        :return:
        """
        for item in self.dot_config_dirs:
            new_dir = Path.home().joinpath(".config").joinpath(item)
            new_dir.mkdir(parents=True, exist_ok=True)

        for _dir in self.dot_config_dirs:
            new_dir = Path.home().joinpath(".config")
            shutil.copytree(self.dot_config_location, new_dir, symlinks=False, ignore=None, copy_function=shutil.copy2,
                            ignore_dangling_symlinks=False, dirs_exist_ok=True)


def main():
    set_up_home = SetupHome()
    user_config = UserConfig()
    set_up_home.copy_dot_files()
    set_up_home.make_home()
    user_config.setup_dot_config()
    set_up_home.make_dot_fvwm()
    user_config.change_to_fish()


if __name__ == "__main__":
    main()
