#!/usr/pkg/bin/python3.13
import shutil
import sys
from pathlib import Path


class RcFile:
    def __init__(self):
        self.rc_file_name = "rc.conf"
        self.rc_file_location = Path("/etc").joinpath(self.rc_file_name)
        # self.rc_file_location = Path(".").joinpath(self.rc_file_name)
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

        try:
            with open(self.rc_file_location, 'w') as file:
                file.write(updated_contents)
        except PermissionError as e:
            raise e

    def append_to_file(self, line: str):
        try:
            with open(self.rc_file_location, "a") as file:
                file.write(f"{line}\n")
        except PermissionError as e:
            raise e

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
            try:
                self.append_to_file(f"{line}=YES")
            except Exception as e:
                raise e


def main():
    rc_update = RcFile()
    try:
        rc_update.update_rc_file()
    except Exception as e:
        print(e)
        sys.exit(1)


if __name__ == "__main__":
    main()
