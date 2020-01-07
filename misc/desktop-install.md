## INSTALLS

- install tint2		[DONE]
- install slim		[DONE] (/usr/pkgsrc/x11/slim)
- install slim-themes	[DONE] (/usr/pkgsrc/graphics/slim-themes)
- install git		[DONE] (/usr/pkgsrc/devel/git)
- install vim		[DONE] (/usr/pkgsrc/editors/vim)
- install xfce4-terminal[DONE] (/usr/pkgsrc/x11/xfce4-terminal)
- install zsh		[DONE]
- install lxterminal	[DONE]
- install lxapperance	[DONE]
- install lxsession	[DONE]
- install xfce4-session	[DONE]
- install bash		[DONE] (/usr/pkgsr/shells/bash)
- install nmap		[DONE] (/usr/pkgsrc/net/nmap)
- install pcmanfm	[DONE] (/usr/pkgsrc/sysutils/pcmanfm)
- install lastpass-cli	[DONE]
- install base64	[DONE] (/usr/pkgsrc/converters/base64)
- install hexchat	[DONE] (/usr/pkgsrc/chat/hexchat)
- install avahi		[DONE] (/usr/pkgsrc/net/avahi)
- install postgresql	[DONE] (/usr/pkgsrc/databases/postgresql11-server)
- install libreoffice	[DONE] (/usr/pkgsrc/misc/libreoffice6-bin)
- install claws		[DONE] (/usr/pkgsrc/mail/claws-mail)
- install PyCharm	[DONE] (/usr/pkgsrc/devel/pycharm-bin)
- install leafpad	[DONE] (/usr/pkgsrc/editors/leafpad)
- install go		[DONE] (/usr/pkgsrc/lang/go)
- install skippy	[DONE] (/usr/pkgsrc/wm/skippy)
- install lighttpd	[] (/usr/pkgsrc/www/lighttpd)
- install couchdb	[] (/usr/pkgsrc/databases/couchdb)
- install john		[] (/usr/pkgsrc/security/john)
- install hugo		[] (/usr/pkgsrc/www/hugo)
- install mutt		[] ()

## Maybe

? install mongodb	[] (/usr/pkgsrc/databases/mongodb)
? install thunderbird	[] (/usr/pkgsrc/mail/thunderbird)

## FAILED

- install bluefish	[FAIL] (/usr/pkgsrc/www/bluefish)
  - pkg_add -v -> works now
- install firefox69	[FAIL] (/usr/pkgsrc/www/firefox)
  - Used pkg_add -v and softlinked libstdc++.so.8 -> libstdc++.so.9.0
  - firefox now works
- install wireshark	[FAIL] (/usr/pkgsrc/net/wireshark)
  lrwxr-xr-x  1 root  wheel  27 Dec 27 09:24 libcrypto.so.12 -> ../../lib/libcrypto.so.14.0
  lrwxr-xr-x  1 root  wheel  27 Dec 23 22:43 libcrypto.so.14 -> ../../lib/libcrypto.so.14.0
  lrwxr-xr-x  1 root  wheel  27 Dec 23 22:43 libcrypto.so.14.0 -> ../../lib/libcrypto.so.14.0
/usr/pkg/lib/libssh.so.4: Undefined PLT symbol "CRYPTO_num_locks" (symnum = 180)
/usr/pkg/lib/libssh.so.4: Undefined PLT symbol "CRYPTO_num_locks" (symnum = 180)
/usr/pkg/lib/libssh.so.4: Undefined PLT symbol "CRYPTO_num_locks" (symnum = 180)
/usr/pkg/lib/libssh.so.4: Undefined PLT symbol "CRYPTO_num_locks" (symnum = 180)


