"""
services.py
This module does three things.
1. Install services (sudo pkgin -y in <service>)
2. Copy the service files from /usr/pkg/share/examples/rc.d to /etc/rc.d
3. Start services (sudo service <name> start)

Requirements:
Root or sudo permissions are needed to install packages, copy file to /etc/rc.d and to start services.
"""


class InstallServices:
    def __init__(self):
        pass


class CopyFilesToRcd:
    def __init__(self):
        pass


class StartServices:
    def __init__(self):
        pass
