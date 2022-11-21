#!/usr/pkg/bin/bash
IFS=$'\n'
count=1
PKGIN_DIR=../netbsd/pkginlist/

for bundle in $(ls $PKGIN_DIR);
do
	echo "${count}) ${bundle}"
	BUNDLE_ARRAY[$count]=${bundle}
	count=$((count+1))
done
unset IFS 
printf "\nSelect an bundle to install: "
read choice
echo "Installing bundle ${BUNDLE_ARRAY[$choice]}"
sudo pkgin -y im ${PKGIN_DIR}${BUNDLE_ARRAY[$choice]}
exit 0
