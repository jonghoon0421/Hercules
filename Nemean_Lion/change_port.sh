# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    change_port.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/23 21:12:25 by jonkim            #+#    #+#              #
#    Updated: 2018/03/16 15:17:12 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# make sure to have "root" access
# Settings/System - "Enable I/O APIC"
# Settings/Network - "Adapter 2 : Host-only Adapter : vboxnet0"

# install ssh
apt-get -y install openssh-server

# back-up your /etc/network/interfaces (optional, but recommended)
cp /etc/network/interfaces /etc/network/interfaces_backup

# set up a static ip address of vboxnet0
"auto enp0s8" >> /etc/network/interfaces
"iface enp0s8 inet static" >> /etc/network/interfaces
"address 192.168.56.42" >> /etc/network/interfaces
"netmask 255.255.255.0" >> /etc/network/interfaces
# note "42" can be anything in between 0 and 255, except 1

# back-up your /etc/ssh/sshd_config (optional, but recommended)
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup

# change port in /etc/ssh/sshd_config
sed -i "s/^#Port .*/Port 55555/g" /etc/ssh/sshd_config

# restart after configuration
service ssh restart
