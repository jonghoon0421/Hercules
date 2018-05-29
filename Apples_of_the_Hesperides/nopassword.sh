# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    nopassword.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/05/04 10:52:12 by jonkim            #+#    #+#              #
#    Updated: 2018/05/04 11:31:50 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

ARGC=("$#")
if [ $ARGC -ne 1 ]; then
	echo "usage: ./nopassword.sh \"<username>@<ip address> -p <port number>\""
	exit 1
fi

# Create RSA key and press ENTER at every prompt
ssh-keygen

# Copy key to remote host
ssh-copy-id $1

# Make sure that .ssh/authorized_keys and all the upper directories
# in the group have [group-read] and NO [group-write] permissions
# Now that is possible with "ssh $1 <command>"
ssh $1 'chmod 640 .ssh/authorized_keys'
