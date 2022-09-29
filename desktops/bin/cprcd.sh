#!/usr/pkg/bin/bash
EXAMPLE_RCD=/usr/pkg/share/examples/rc.d
ETC_RCD=/etc/rc.d
for x in dbus hal avahidaemon famd
do
	sudo cp $EXAMPLE_RCD/$x $ETC_RCD/$x
done
