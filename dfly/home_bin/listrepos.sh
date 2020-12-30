#!/bin/sh

GHUSER=rgeorgia
GITHUB_API_TOKEN="0509d92fb40bb278ff26d470c2c0955ebc1eab87"
#GITHUB_API_TOKEN="9f2dad4e09dd337d525d4f6353323cd333d3e7a8"

usage() 
{
	echo "[all|cloned|private]"
	echo "$1 is not valid"
	exit
}

case $1 in
	"all")
		echo "List all your repos"
		curl --silent "https://api.github.com/users/$GHUSER/repos" | grep -o 'git@[^"]*'
		#curl "https://api.github.com/users/$GHUSER/repos"
		;;
	cloned)
		echo "Your cloned repos"
		curl -s --silent "https://api.github.com/users/$GHUSER/repos" | grep -w clone_url | grep -o '[^"]\+://.\+.git'
		;;
	private)
		echo "Private repos"
		curl --silent "https://api.github.com/users/$GHUSER/repos?access_token=$GITHUB_API_TOKEN" | grep -w clone_url
		;;
	*)
		echo "Invalid parameter"
		usage
		;;
esac
