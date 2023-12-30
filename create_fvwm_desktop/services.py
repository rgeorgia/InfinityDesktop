#!/usr/pkg/bin/python3.11
import shutil
import subprocess
import sys
from pathlib import Path


class Services:
    """Class of services needed"""

    def __init__(self):
        self._rc_services: list = ["dbus", "avahidaemon", "rpcbind", "famd", "hal", "xdm"]
        self._services_to_copy: list = ["dbus", "avahidaemon", "famd", "hal",]
        self._services_to_start: list = ["dbus", "avahidaemon", "rpcbind", "famd", "hal",]
        self._services_to_install: list = ["dbus", "hal", "avahi", "fam"]

    @property
    def rc_services(self) -> list:
        return self._rc_services

    def remove_from_rc_services(self, value: str):
        self._rc_services.remove(value)

    @property
    def services_to_copy(self) -> list:
        return self._services_to_copy

    @property
    def services_to_start(self) -> list:
        return self._services_to_start

    @property
    def services_to_install(self) -> list:
        return self._services_to_install

    def start_services(self):
        for item in self.services_to_start:
            subprocess.run(f"service {item} start", shell=True)

    def install_services(self):
        for item in self.services_to_install:
            subprocess.run(f"pkgin -y in {item}", shell=True)


class RcFile:
    def __init__(self):
        self.rc_file_name = "rc.conf"
        self.rc_file_location = Path("/etc").joinpath(self.rc_file_name)
        self.example_rcd = Path("/usr/pkg/share/examples/rc.d")
        self.etc_rcd = Path("/etc/rc.d")
        self.tmp_backup = Path("/tmp").joinpath(f"{self.rc_file_name}.bk")

    def copy_to_etc_rcd(self, files: list):
        for item in files:
            source = self.example_rcd.joinpath(item)
            target = self.etc_rcd.joinpath(item)
            try:
                print(f"Copying {source} to {target}")
                shutil.copy(source, target)

            except PermissionError as perr:
                raise perr

            except Exception as err:
                raise err

    def backup_rc_conf(self):
        # Added services to rc.conf then start them.
        # Make a copy for "just in case"
        # cp /etc/rc.conf /tmp/rc.conf.bk
        print(f"Backing up {self.rc_file_location} to {self.tmp_backup}")
        shutil.copy(self.rc_file_location, self.tmp_backup)

    def get_content(self):
        content_dict = {}
        with self.rc_file_location.open() as rcf:
            c = rcf.readlines()
        for line_no, item in enumerate(c, 1):
            # skip commented lines
            if "#" in item:
                continue
            content_dict[line_no] = item.strip()

        return content_dict

    def search_and_replace(self, search_word: str, replace_word: str):
        with open(self.rc_file_location, 'r') as file:
            file_contents = file.read()

        updated_contents = file_contents.replace(search_word, replace_word)

        with open(self.rc_file_location, 'w') as file:
            file.write(updated_contents)

    def append_to_file(self, line: str):
        with open(self.rc_file_location, "a") as file:
            file.write(f"{line}\n")

    def update_rc_file(self, content: dict, service: Services):
        for key, value in content.items():
            s = value.split("=")[0]
            if s in service.rc_services:
                print(f"Found {s} in {self.rc_file_name}")
                if "yes" not in value.split("=")[1].lower():
                    self.search_and_replace(f"{s}=NO", f"{s}=YES")
                    print(f"Changing {s}=NO to {s}=YES")
                    service.remove_from_rc_services(value=s)
                if "yes" in value.split("=")[1].lower():
                    print(f"{s} already set")
                    service.remove_from_rc_services(value=s)

        for line in service.rc_services:
            print(f"Appending {line}=YES to {self.rc_file_name}")
            self.append_to_file(f"{line}=YES")


if __name__ == "__main__":
    services = Services()
    rc_files = RcFile()
    rc_files.backup_rc_conf()
    services.install_services()
    try:
        rc_files.copy_to_etc_rcd(files=services.services_to_copy)
    except Exception as e:
        print(e)
        sys.exit(1)
    lines = rc_files.get_content()
    rc_files.update_rc_file(content=lines, service=services)
    services.start_services()
