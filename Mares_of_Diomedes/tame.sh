# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tame.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/04/14 19:34:38 by jonkim            #+#    #+#              #
#    Updated: 2018/04/14 22:57:52 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

gcc -Wall -Wextra -Werror virus.c -o new_manger
echo "Which one?"
read M_VIRUS
./$M_VIRUS &

# using SIGKILL for all
kill -9 $(pgrep crap lampon ruins xanthos yes)
kill -9 $(top -l 1 | grep manger | awk '{ print $1 }')

# using specific SIG for each
# kill -4 $(pgrep podargos ruins)
# kill -5 $(pgrep lampon)
# kill -10 $(pgrep xanthos yes)
# kill -11 $(pgrep deinos)
# kill -1 $(top -l 1 | grep manger | awk '{print $1}')

# 1) SIGHUP 2) SIGINT 3) SIGQUIT 4) SIGILL
# 5) SIGTRAP 6) SIGABRT 7) SIGBUS 8) SIGFPE
# 9) SIGKILL 10) SIGUSR1 11) SIGSEGV 12) SIGUSR2
# 13) SIGPIPE 14) SIGALRM 15) SIGTERM 17) SIGCHLD
# 18) SIGCONT 19) SIGSTOP 20) SIGTSTP 21) SIGTTIN
# 22) SIGTTOU 23) SIGURG 24) SIGXCPU 25) SIGXFSZ
# 26) SIGVTALRM 27) SIGPROF 28) SIGWINCH 29) SIGIO
# 30) SIGPWR 31) SIGSYS 34) SIGRTMIN 35) SIGRTMIN+1 ... and so on

rm -rf *.poo
