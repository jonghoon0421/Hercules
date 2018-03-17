# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    sch.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/16 13:32:30 by jonkim            #+#    #+#              #
#    Updated: 2018/03/16 15:13:44 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
filepath=/tmp/temp_file
outputpath=`tty`
echo "echo \"\nHello! This is my task. Bye!\" > $outputpath" > $filepath
echo "echo \"\nPress <Enter> to exit!\" > $outputpath" >> $filepath
at 08:42 AM 12/21/2018 < $filepath
rm -rf $filepath
echo "Job number && Date and time of the execution: " "`atq`"
