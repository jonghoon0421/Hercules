/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stables.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/23 20:11:23 by jonkim            #+#    #+#             */
/*   Updated: 2018/03/23 22:22:03 by jonkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <unistd.h>

typedef struct 			s_unrolled {
	struct s_unrolled*	next;
	unsigned			count;
	int				values[8];
} 						t_unrolled;

t_unrolled* new_unrolled(void) {
	t_unrolled*	new = malloc(sizeof(t_unrolled));
	new->next = NULL;
	new->count = 0;
	return new;
}

long	sum_unrolled(t_unrolled* list) {
	long		sum;
	int			size;
	sum = 0;
	while (list)
	{
		size = list->count;
		do {
			sum += list->values[--size];
		} while (size != 0);
		list = list->next;
	}
	return (sum);
}

void	del_unrolled(t_unrolled* list)
{
	t_unrolled	*tmp;

	while (list != NULL)
	{
		tmp = list;
		list = list->next;
		free(tmp);
	}
}

int		main(void) {
	t_unrolled*	list;
	t_unrolled*	tmp;
	int			val;
	unsigned	i;
	long long	magic;

	magic = 753057078882375803;
	val = 0;
	i = 0;
	list = NULL;
	while (i < 42)
	{
		tmp = new_unrolled();
		while (tmp->count < 8)
		{
			tmp->values[tmp->count] = val++;
			++tmp->count;
		}
		++i;
		if (!list)
			list = tmp;
		else
		{
			tmp->next = list;
			list = tmp;
		}			
	}
	magic += sum_unrolled(list);
	write(1, &magic, 8);
	del_unrolled(list);
	return(0);
}