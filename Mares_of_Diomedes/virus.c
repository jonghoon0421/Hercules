/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   virus.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/04/14 19:45:41 by jonkim            #+#    #+#             */
/*   Updated: 2018/04/14 22:57:28 by jonkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

volatile sig_atomic_t	checker = 0;

static void				ft_loop(int sig)
{
	sig == SIGINT ? printf("\nsignal = SIGINT\n") : 0;
	sig == SIGTERM ? printf("\nsignal = SIGTERM\n") : 0;
	sig == SIGHUP ? printf("\nsignal = SIGHUP\n") : 0;
	sig == SIGQUIT ? printf("\nsignal = SIGQUIT\n") : 0;
	sig == SIGABRT ? printf("\nsignal = SIGABRT\n") : 0;
	sig == SIGALRM ? printf("\nsignal = SIGALRM\n") : 0;
	sig == SIGKILL ? printf("\nsignal = SIGKILL\n") : 0;
	checker = 0;
}

int		init_sig(struct sigaction *act, void (*func)(int))
{
	int		ret;

	ret = 0;
	bzero(act, sizeof(*act));
	(*act).sa_handler = *func;
	ret += sigaction(SIGINT, act, NULL);
	ret += sigaction(SIGTERM, act, NULL);
	ret += sigaction(SIGHUP, act, NULL);
	ret += sigaction(SIGQUIT, act, NULL);
	ret += sigaction(SIGABRT, act, NULL);
	ret += sigaction(SIGALRM, act, NULL);
	return (ret);
}

int						main(void)
{
	struct sigaction	act;
	int					pid;

	pid = 0;
	init_sig(&act, &ft_loop);
	while (!checker)
	{
		pid = fork();
		printf("more and more ...\n");
		sleep(3);
	}
	return (0);
}
