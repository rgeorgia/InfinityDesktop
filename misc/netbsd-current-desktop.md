## NOTES 

- mk.conf => ACCEPTABLE_LICENSES+= vim-license esdl-license server-side-public-license
- updated wpa_supplicant.conf and rc.conf for wireless


## TODO

- Tune login.conf
- Checkout nomadBSD for openbox and tint2 configuration ideas

# NetBSD Current (9.99.23) Desktop

- downloaded netbsd current from cdn site
- installed into VirtualBox
  - set system to EFI
  - went through install
  - during install pulled in current pkgsrc
  - **Would not boot using efi, at shell prompt** 
  ```bash
  > boot hd0b:/netbsd
  ```
  - don't forget to include the /. The "help" message leaves that part out.
- make install sudo
- added user to sudo file with visudo
- added user to operator with usermod -G operator username
- make install clean clean-depends sysutils/dbus
  - cp /usr/pkg/share/example/rc.d/dbus /etc/rc.d/.
- make install clean clean-depends sysutils/fam
  - cp /usr/pkg/share/example/rc.d/famd /etc/rc.d/.
- make install openbox
- **make sure you run as root mozilla-rootcerts install**
- installed slim and slim-themes
- installed feh for setting backgrounds for openbox
- installed tint2

## INSTALLS

- install tint2			[]
- install slim			[]
- install slim-themes		[]
- install tint2			[]
- install git			[]
- install vim			[]
- install zsh			[]
- install bash			[]
- install nmap			[]
- install wireshark		[]
- install firefox68		[]
- install pcmanfm		[]
- install bluefish		[]
- install base64		[] (/usr/pkgsrc/converters/base64)
- install hexchat		[] (/usr/pkgsrc/chat/hexchat)
- install avahi			[] (/usr/pkgsrc/net/avahi)
- install postgresql		[] (/usr/pkgsrc/databases/postgresql12-server)
- install libreoffice		[] (/usr/pkgsrc/misc/libreoffice6-bin)
- install PyCharm		[] (/usr/pkgsrc/devel/pycharm-bin)
- install leafpad		[]
- install go			[]
- install claws-mail		[]


