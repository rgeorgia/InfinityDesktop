import shutil
import subprocess
from pathlib import Path
from typing import Self


class InstallServices:
    """Class of services needed"""

    def __init__(self):
        self._services_to_install: list = ["dbus", "avahi", "fam"]

    @property
    def services_to_install(self) -> list:
        return self._services_to_install

    def install_services(self):
        for item in self.services_to_install:
            sp = subprocess.run(f"sudo pkgin -y in {item}", shell=True, capture_output=True)
            print(f"Install {item}, {sp.stdout.decode('utf-8')}, {sp.returncode}")


class CopyExampleToRcd:
    def __init__(self):
        self._services_to_copy: list = ["dbus", "avahidaemon", "famd"]
        self.example_rcd = Path("/usr/pkg/share/examples/rc.d")
        self.etc_rcd = Path("/etc/rc.d")

    @property
    def services_to_copy(self) -> list:
        return self._services_to_copy

    def copy_to_etc_rcd(self):
        for item in self._services_to_copy:
            source = self.example_rcd.joinpath(item)
            target = self.etc_rcd.joinpath(item)
            try:
                print(f"Copying {source} to {target}")
                # Not using shutil.copy because we need sudo privilege
                # shutil.copy(source, target)
                sp = subprocess.run(f"sudo cp {source} {target}", shell=True, capture_output=True)
                if sp.returncode != 0:
                    print(f"Error copying {source} to {target}")

            except PermissionError as err:
                raise err

            except Exception as err:
                raise err


class StartServices:
    def __init__(self):
        self._services_to_start: list = ["dbus", "avahidaemon", "rpcbind", "famd", ]

    @property
    def services_to_start(self) -> list:
        return self._services_to_start

    def start_services(self):
        for item in self.services_to_start:
            subprocess.run(f"sudo service {item} start", shell=True)


class RcFile:
    def __init__(self):
        self.rc_file_name = "rc.conf"
        self.rc_file_location = Path("/etc").joinpath(self.rc_file_name)
        self.tmp_backup = Path("/tmp").joinpath(f"{self.rc_file_name}.bk")
        self._rc_services: list = ["dbus", "avahidaemon", "rpcbind", "famd", "xdm"]

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

    @property
    def rc_services(self) -> list:
        return self._rc_services

    def remove_from_rc_services(self, value: str):
        self._rc_services.remove(value)

    def update_rc_file(self):
        content = self.get_content()
        for key, value in content.items():
            s = value.split("=")[0]
            if s in self.rc_services:
                print(f"Found {s} in {self.rc_file_name}")
                if "yes" not in value.split("=")[1].lower():
                    self.search_and_replace(f"{s}=NO", f"{s}=YES")
                    print(f"Changing {s}=NO to {s}=YES")
                    self.remove_from_rc_services(value=s)
                if "yes" in value.split("=")[1].lower():
                    print(f"{s} already set")
                    self.remove_from_rc_services(value=s)

        for line in self.rc_services:
            print(f"Appending {line}=YES to {self.rc_file_name}")
            self.append_to_file(f"{line}=YES")


class InitServices:
    def __init__(self):
        self.install_services = InstallServices()
        self.start_services = StartServices()
        self.rc_file = RcFile()
        self.copy_to_rcd = CopyExampleToRcd()

    def run(self) -> Self:
        self.install_services.install_services()
        self.copy_to_rcd.copy_to_etc_rcd()
        self.rc_file.update_rc_file()
        self.start_services.start_services()

        return self
