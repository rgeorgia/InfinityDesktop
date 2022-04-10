def has_rcd_file() -> bool:
    pass


def list_example_rcd() -> list:
    pass


def copy_example_rcd(rc_files_to_move):
    pass


def update_rc_config(rc_files_to_move, host_name):
    pass


def prompt_for_hostname() -> str:
    pass


def main():
    if not has_rcd_file():
        # get list from /etc/rc.d and write contents to ~/.config/infinity/rcd.txt
        pass

    host_name = prompt_for_hostname()

    rc_files_to_move = list_example_rcd()
    copy_example_rcd(rc_files_to_move)

    update_rc_config(rc_files_to_move, host_name)


if __name__ == '__main__':
    main()