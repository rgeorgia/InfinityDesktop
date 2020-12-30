#!/bin/sh
rsync -avz --delete public/ rgeorgia@192.168.1.111:/usr/local/www/prayerlist
rsync -avz --delete public/ rgeorgia@192.168.1.111:/usr/local/www/notes

