#!/bin/sh
# baraction.sh for spectrwm status bar
# https://gitlab.com/dwt1/dotfiles/-/blob/master/baraction.sh?ref_type=heads

## DISK
hdd() {
  hdd=`df -h | grep dk | awk '{print $5}'| perl -ne 'printf("%s",$_)'`
  echo -e "HDD: $hdd"
}

## RAM
mem() {
  mem=`sysctl hw.usermem64 | cut -d= -f2 | perl -ne 'chomp; printf "%.1f", $_ / 1024 / 1024'`
  echo -e "MEM: $mem"
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

## VOLUME
vol() {
    vol=`sndioctl output.level | cut -d= -f2 | perl -ne 'chomp; printf "%.1f", $_ * 100'`
    echo -e "VOL: $vol"
}

SLEEP_SEC=5
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "| $(mem) | $(hdd) | $(vol) |"
	sleep $SLEEP_SEC
done

