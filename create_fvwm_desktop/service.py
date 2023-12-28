#!/usr/pkg/bin/python3.11

from pathlib import Path


class Services:
    """Class of services needed"""

    def __init__(self):
        self._rc_services: list = ["dbus", "avahidaemon", "rpcbind", "famd", "hal", "xdm"]
        self._services_to_copy_or_start: list = ["dbus", "avahidaemon", "rpcbind", "famd", "hal", ]

    @property
    def rc_services(self) -> list:
        return self._rc_services

    def remove_from_rc_services(self, value: str):
        self._rc_services.remove(value)

    @property
    def services_to_copy_or_start(self) -> list:
        return self._services_to_copy_or_start


# RC_FILE_LOCATION=Path("/etc/rc.conf")
RC_FILE_LOCATION = Path("./rc.conf")


def get_rc_content(file_name: Path) -> dict:
    content_dict = {}
    with file_name.open() as rcf:
        c = rcf.readlines()
    for line_no, item in enumerate(c, 1):
        # skip commented lines
        if "#" in item:
            continue
        content_dict[line_no] = item.strip()

    return content_dict


def search_and_replace(file_path: Path, search_word: str, replace_word: str):
    with open(file_path, 'r') as file:
        file_contents = file.read()

    updated_contents = file_contents.replace(search_word, replace_word)

    with open(file_path, 'w') as file:
        file.write(updated_contents)


def append_to_file(file_path: Path, line: str):
    with open(file_path, "a") as file:
        file.write(f"{line}\n")


def update_rc_file(file: Path, content: dict):
    service = Services()
    for key, value in content.items():
        s = value.split("=")[0]
        if s in service.rc_services:
            if "yes" not in value.split("=")[1].lower():
                search_and_replace(file, f"{s}=NO", f"{s}=YES")
                service.remove_from_rc_services(value=s)
            if "yes" in value.split("=")[1].lower():
                service.remove_from_rc_services(value=s)

    for line in service.rc_services:
        append_to_file(file, f"{line}=YES")


if __name__ == "__main__":
    rc_file = RC_FILE_LOCATION
    lines = get_rc_content(rc_file)
    update_rc_file(rc_file, lines)
