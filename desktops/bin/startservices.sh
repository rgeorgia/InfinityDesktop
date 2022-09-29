# Added services to rc.conf then start them.
# MAKE SURE YOU HAVE THE -a FLAG OTHERWISE YOU'LL OVERWRITE THE rc.conf FILE
# Make a copy for "just in case"
cp /etc/rc.conf /tmp/rc.conf.bk
for x in dbus avahidaemon famd hal
do
	grep $x /etc/rc.conf
	if [ $? -eq 1 ]
	then
		echo "${x}=YES" | sudo tee -a /etc/rc.conf
		sudo service $x start
	else
		echo "${x} is already in rc.conf"
		sudo service $x restart
	fi
done
