#!/usr/pkg/bin/python3.10
"""
init_rc_conf.py updates the /etc/rc.conf file. Need root permission
"""
import platform
from pathlib import Path
import os
import sys
import shutil

CONFIG_PATH = f"{Path.home()}/.config/infinity"
EXAMPLE_RCD = "/usr/pkg/share/examples/rc.d/"
ETC_RCD = "/etc/rc.d"
RC_CONF = "/etc/rc.conf"


def has_rcd_file() -> bool:
    return Path(f"{CONFIG_PATH}/rcd.txt").exists()


def list_example_rcd() -> list:
    return [item for item in Path(EXAMPLE_RCD).iterdir()]


def copy_example_rcd(rc_files_to_move: list):
    # TODO: this does not retain file permission
    try:
        for item in rc_files_to_move:
            shutil.copy2(f"{item}", f"{ETC_RCD}/{item.name}", follow_symlinks=False)
    except shutil.SameFileError:
        pass
    except PermissionError:
        print("You need root privs to copy files")
        sys.exit(1)
    except FileNotFoundError as fne:
        print(f"{fne}")


def update_rc_config(rc_files_to_move, host_name):
    service_to_activate = ["dbus", "hal", "rpcbind", "famd", "avahidaemon", "slim"]
    services = [item.name for item in rc_files_to_move]
    services.append("rpcbind")
    for item in service_to_activate:
        if item in services:
            print(f"{item}=YES")


def prompt_for_hostname() -> str:
    hostname = platform.uname().node
    return hostname


def create_config_infinity():
    try:
        os.makedirs(CONFIG_PATH)
    except PermissionError as e:
        print(f"Could not create {CONFIG_PATH}: {e}")
        sys.exit(1)


def main():
    if not Path(CONFIG_PATH).exists():
        create_config_infinity()

    if not has_rcd_file():
        # creating a list of what's in /etc/rc.d just in case we need to roll back
        with open(f"{CONFIG_PATH}/rcd.txt", "w") as rcd_file:
            for item in [item.name for item in Path("/etc/rc.d").iterdir()]:
                rcd_file.write(f"{item}\n")

    host_name = prompt_for_hostname()

    rc_files_to_move = list_example_rcd()
    copy_example_rcd(rc_files_to_move)

    update_rc_config(rc_files_to_move, host_name)


if __name__ == "__main__":
    main()
