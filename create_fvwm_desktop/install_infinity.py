#!/usr/pkg/bin/python3.11
from init_services import InitServices


def main():
    services = InitServices()
    services.run()


if __name__ == "__main__":
    main()
