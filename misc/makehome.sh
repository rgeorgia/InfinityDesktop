#!/bin/sh

# Documents Pictures/backgrounds Downloads Templates Desktop Videos workspace bin
for dirs in Documents Pictures/backgrounds Downloads Templates Desktop Videos workspace bin
do
	if [ ! -d $HOME/$dirs ]
	then
		mkdir -p $HOME/$dirs
	fi
done
