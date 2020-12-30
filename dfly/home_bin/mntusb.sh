#!/usr/local/bin/bash
mount | grep data > /dev/null
if [ $? -ne 0 ];then
	sudo mount -t hammer2 /dev/da8s1e /mnt/data
fi
