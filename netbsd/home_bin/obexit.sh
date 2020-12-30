#!/usr/bin/env bash
if [ -z $1 ]; then
	echo "Usage: $0 [reboot|poweroff]"
	exit
fi
if [ $1 = reboot ];then
   zenity --question --ok-label "Reboot" --text "Reboot $HOST?" && sudo /sbin/reboot
elif [ $1 = poweroff ];then
      zenity --question --ok-label "Shudown" --text "Shutdown $HOST?" && sudo /sbin/poweroff
fi
