#!/usr/bin/env python3.9
import platform
from collections import defaultdict
from pathlib import Path

key_list = [
    "Name",
    "Exec",
    "Terminal",
    "Categories",
]
categories = {
    "Desktop",
    "Development",
    "FileManager",
    "FileTools",
    "Graphics",
    "Monitor",
    "Network",
    "Office",
    "Settings",
    "System",
    "Terminal",
    "TextEditor",
    "Utility",
}

menu_item_skip_list = [
    '/usr/local/libexec/geoclue-2.0/demos/where-am-i', '/usr/local/bin/bssh', 'bvnc',
    'lxshortcut', 'xfce4-about', 'gtk3-demo', 'xscreensaver-demo', 'pcmanfm --desktop-pref',
    '/usr/local/bin/menulibre', 'libfm-pref-apps', 'xfce4-terminal --preferences',
    '/usr/local/libexec/gcr-prompter', '/usr/local/bin/gcr-viewer', '/usr/local/bin/bvnc',
    'firefox -private-window', 'compton',
]

short_names = {
    "New Drawing": "Inkscape",
    "Ristretto Image Viewer": "Ristretto",
    "GNU Image Manipulation Program": "GIMP",
    "Burn Image (xfburn)": "xfburn",
    "File Manager PCManFM": "pcmanfm",
    "JetBrains PyCharm Professional Edition IDE": "PyCharm Pro",
    "Bluefish Editor": "bluefish",
}


def get_desktop_apps() -> list:
    if "netbsd".lower() in platform.platform().lower():
        local_path = "pkg"
    else:
        local_path = "local"

    application_path = f"/usr/{local_path}/share/applications/"
    desktop_ext = "desktop"
    p = Path(application_path)
    return list(p.glob(f"*.{desktop_ext}"))


def build_menu_items(lines) -> dict:
    menu_dict = {}
    for line in lines:
        try:
            key, value = line.strip().split("=")
        except ValueError:
            continue
        if key in key_list and "[" not in key:
            if key == "Categories":
                usable_category = value.split(';')
                usable_category = set(usable_category)
                value = list(categories.intersection(usable_category))
            # print(f"{key} : {value}")
            menu_dict[key] = value
    return menu_dict


def menu_no_categories(menu_list: list):
    for item in menu_list:
        print(item)


def menu_by_category(menu_list: list):
    cat_dict = defaultdict(list)
    for item in menu_list:
        if not item.get('Categories'):
            category = "Misc"
        elif 'FileManager' in item.get('Categories'):
            category = 'FileManager'
        else:
            category = item.get('Categories')[0]

        cat_dict[category].append(item)

    # print("DestroyMenu MyMenu")
    # print('AddToMenu MyMenu "My Applications" Title')
    # print('+ "" Nop')

    for key_category, value in cat_dict.items():
        print(f'+ "[{key_category}]" nop')

        for item in value:
            if item.get('Exec') in menu_item_skip_list:
                continue

            if key_category == "Settings" and "xfce4" in item.get('Exec'):
                continue

            if item.get('Exec') is not None and "%" in item.get('Exec'):
                item['Exec'] = item.get('Exec')[:-3]

            if item.get('Terminal') == 'true':
                print(f"+ {item.get('Name')} Exec exec uxterm {item.get('Exec')}")
            else:
                if short_names.get(item.get('Name')):
                    name = short_names.get(item.get('Name'))
                else:
                    name = item.get('Name')
                print(f"+ \"{name}\" Exec exec {item.get('Exec')}")
        print(f'+ "" nop')


# def print_menu(menu):
#     pass


def main():
    # for future parameter later for with_category
    with_category = True

    menu_list = []

    for desktop_item in get_desktop_apps():
        with open(str(desktop_item)) as f:
            lines = f.readlines()

        menu_item_dict = build_menu_items(lines)
        menu_list.append(menu_item_dict)

    if with_category:
        menu_by_category(menu_list=menu_list)
    else:
        menu_no_categories(menu_list=menu_list)


if __name__ == "__main__":
    main()
