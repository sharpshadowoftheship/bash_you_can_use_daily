#!/bin/bash

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.d
tmp="Port $1"
sed -e "0,/Port/s/.*Port.*/$tmp/" /etc/ssh/sshd_config.d > /etc/ssh/sshd_config

semanage port -a -t ssh_port_t -p tcp $1
firewall-cmd --permanent --zone=public --add-port=$1/tcp &>/dev/null
firewall-cmd --reload &>/dev/null

systemctl restart sshd