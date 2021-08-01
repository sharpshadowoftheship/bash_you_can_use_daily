#!/bin/bash


if [ $(id -u) -eq 0 ]
then
        echo "Choose id of your temporary user: (it must be the number beetwen 3000 and 3256)"
        read thisid
        if [[ $thisid<3001 || $thisid>3255 ]]
        then
                echo "Inproper id"
                exit 2
        fi
        tmp1=$(date +%N | sha512sum | head -c10)
        useradd -m -u $thisid "u$tmp1"
        nmcli connection down con1 &>/dev/null #con1 is my WAN connection
        nmcli connection add ipv4.address "10.0.0.$(($thisid%1000))" ipv4.gateway 10.0.0.0 type ethernet con-name "LAN$thisid" ifname enp0s8 &>/dev/null
        nmcli connection up "LAN$thisid" &>/dev/null
        nmcli connection modify "LAN$thisid" ipv4.method manual &>/dev/null
        nmcli connection up "LAN$thisid" &>/dev/null
        systemctl stop NetworkManager
        su - "u$tmp1"
        #scp -r /home/"u$tmp1" 10.0.0.0:/home
        echo "You stopped your work before expected finishing time; I hope you know what you do and wish you high grade ;)"
        systemctl start NetworkManager
        nmcli connection up con1 &>/dev/null
        nmcli connection delete "LAN$thisid" &>/dev/null
        userdel -r "u$tmp1"
        echo " "
        echo "Everything that you left on this host exists no more"
else
        echo "You have to be root to execute this script"
        exit 1
fi
exit 0