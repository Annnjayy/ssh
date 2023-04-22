#!/bin/bash
wget -O /tmp/menu-master.zip "https://raw.githubusercontent.com/Annnjayy/ssh/main/config/menu.zip" >/dev/null 2>&1
7z e  /tmp/menu-master.zip -o/tmp/menu/ >/dev/null 2>&1
chmod +x /tmp/menu/*
mv /tmp/menu/* /usr/sbin/
rm /root/update.sh
clear
echo -e " ${green} Update Script Done......"
sleep 1.5
