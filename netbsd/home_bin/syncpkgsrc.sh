DEST=/public/pub/pkgsrc/packages/NetBSD/amd64/9.0_RC1/All/
SRC=/build/pkgsrc/packages/All/

for x in $(ls ${SRC})
do
	echo $x
	tput cuu1
	if [ -f ${DEST}${x} ]
	then
		first=$(md5 -q ${SRC}${x})
		second=$(md5 -q ${DEST}${x})
		if [ "$first" != "$second" ]
		then
			cp -v ${SRC}${x} ${DEST}${x}
		fi
	else
		cp -v ${SRC}${x} ${DEST}${x}
	fi
	tput ed
done
echo
