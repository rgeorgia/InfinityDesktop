#!/usr/bin/env bash
#URL=https://cdn.netbsd.org/pub/NetBSD-daily/HEAD/latest/amd64/binary/kernel
URL=http://nycdn.netbsd.org/pub/NetBSD-daily/HEAD/latest/amd64/binary/kernel
BASE=${PWD}

for x in $(cat $HOME/bin/kernel.list)
do
	ftp ${URL}/$x
done
