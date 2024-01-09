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


class InitServices:
    def __init__(self):
        self.install_services = InstallServices()
        self.start_services = StartServices()
        self.copy_to_rcd = CopyExampleToRcd()

    def run(self) -> Self:
        self.install_services.install_services()
        self.copy_to_rcd.copy_to_etc_rcd()
        result = subprocess.run(f"sudo ./update_rc.py", shell=True,  capture_output=True)
        self.start_services.start_services()

        return self
