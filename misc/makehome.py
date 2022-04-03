#!/usr/pkg/bin/python3.9
from pathlib import Path
import shutil


def make_home_dirs():
    dir_list = [
        "Documents",
        "Pictures/backgrounds",
        "Downloads",
        "Templates",
        "Desktop",
        "Videos",
        "workspace",
        "bin",
        "nowhere",
    ]

    for item in dir_list:
        Path.mkdir(Path.home().joinpath(item), parents=True, exist_ok=True)


def copy_dot_files():
    working_dir = 'workspace/InfinityDesktop/misc'
    p = Path(Path.home().joinpath(working_dir))
    for item in list(p.glob('dot-*')):
        new_file = Path.home().joinpath(f".{item.parts[-1].split('dot-')[1]}")
        shutil.copy(item,new_file)

def main():
    make_home_dirs()
    copy_dot_files()


if __name__ == "__main__":
    main()
