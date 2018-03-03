/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/01 15:51:17 by jonkim            #+#    #+#             */
/*   Updated: 2018/03/02 22:37:39 by jonkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <strings.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#define RETURN_SUCCESS 0
#define RETURN_FAILURE 1

int		set_server(void)
{
	int					socket_fd;
	int					client_sock;
	int					c;
	int					read_size;
	struct sockaddr_in	server;
	struct sockaddr_in	client;
	char				ret_str[1000];

	// create socket
	socket_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (socket_fd == -1)
	{
		printf("Error: socket creation failed.\n");
		return (RETURN_FAILURE);
	}
	else
		printf("Socket created.\n");
	// prepare the sockaddr_in struct
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
//	server.sin_addr.s_addr = inet_addr("192.168.56.42");
	server.sin_port = htons(8100);
	// bind
	if (bind(socket_fd, (struct sockaddr*)&server, sizeof(server)) < 0)
	{
		printf("Error: bind failed.\n");
		return (RETURN_FAILURE);
	}
	else
		printf("Bind done.\n");
	// listen
	if (listen(socket_fd, 10) != 0)
	{
		printf("Error: listen failed.\n");
		return (RETURN_FAILURE);
	}
	// accept incoming connection from client
	c = sizeof(struct sockaddr_in);
	client_sock = accept(socket_fd, (struct sockaddr*)&client, (socklen_t*)&c);
	if (client_sock < 0)
	{
		printf("Error: failed to accept.\n");
		return (RETURN_FAILURE);
	}
	else
		printf("Connection accpeted.\n");
	// receive a message from client
	while ((read_size = recv(client_sock, ret_str, 1000, 0)) > 0)
	{
		write(client_sock, ret_str, strlen(ret_str));
		bzero(ret_str, 1000);
	}
	if (read_size == 0)
	{
		printf("Client disconnected.\n");
		return (RETURN_SUCCESS);
	}
	else if (read_size == -1)
	{
		printf("Error: recv failed.\n");
		return (RETURN_FAILURE);
	}
	return (RETURN_SUCCESS);
}

int		main(int ac, char **av)
{
	pid_t	pid;
	pid_t	sid;

	if (ac == 2 && strcmp(av[1], "-D") == 0)
	{
		pid = 0;
		sid = 0;
		pid = fork(); // fork a new child process
		if (pid < 0)
		{
			printf("Error: failed to fork().\n");
			exit(EXIT_FAILURE);
		}
		// terminate the parent process if we have a "good PID"
		if (pid > 0)
			exit(EXIT_SUCCESS);
		// change the file mode mask
		umask(0);
		// create a new SID for the child process
		sid = setsid();
		if (sid < 0)
			exit(EXIT_FAILURE);
		// close out the standard fd's
		close(STDIN_FILENO);
		close(STDOUT_FILENO);
		close(STDERR_FILENO);

		// DAEMON specific initialization below ...

		set_server();

		// DAEMON specific initialization above ...
		exit(EXIT_SUCCESS);
	}
	else if (ac == 1)
		set_server();
	else
	{
		printf("[./exec] - normal server\n");
		printf("[./exec -D] - daemon server\n");
	}
	return (RETURN_SUCCESS);
}
