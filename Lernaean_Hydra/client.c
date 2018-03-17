/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/01 16:53:09 by jonkim            #+#    #+#             */
/*   Updated: 2018/03/16 15:20:16 by jonkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#define RETURN_SUCCESS 0
#define RETURN_FAILURE 1

int		main(void)
{
	int					sock;
	struct sockaddr_in	server;
	char				msg[1000];
	char				server_reply[1000];
	int					len;

	// create socket
	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock == -1)
	{
		printf("Error: socket creation failed.\n");
		return (RETURN_FAILURE);
	}
	else
		printf("Socket created.\n");
//	server.sin_addr.s_addr = inet_addr("192.168.56.42");
	server.sin_addr.s_addr = inet_addr("127.0.0.1");
	server.sin_family = AF_INET;
	server.sin_port = htons(8100);
	// connect to remote server
	if (connect(sock, (struct sockaddr*)&server, sizeof(server)) != 0)
	{
		printf("Error: connection failed.\n");
		return (RETURN_FAILURE);
	}
	else
		printf("Connected.\n");
	// keep the communication
	sleep(1);
	while (1)
	{
		printf("Enter your message : ");
		fgets(msg, 1000, stdin);
		len = strlen(msg);
		if (len > 0 && msg[len - 1] == '\n')
			msg[len - 1] = '\0';
		// send some data
		if (strcmp(msg, "Exit -y") == 0)
			return (RETURN_SUCCESS);
		if (send(sock, msg, strlen(msg), 0) < 0)
		{
			printf("Error: failed to send.\n");
			return (RETURN_FAILURE);
		}
		// receive a reply from the server
		bzero(server_reply, 1000);
		if (recv(sock, server_reply, 1000, 0) < 0)
		{
			printf("Error: recv failed.\n");
			return (RETURN_FAILURE);
		}
		else
		{
		printf("Server reply : ");
		printf("%s\n", server_reply);
		}
	}
	close(sock);
	return (0);
}
