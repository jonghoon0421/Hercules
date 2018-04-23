# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/30 20:38:53 by jonkim            #+#    #+#              #
#    Updated: 2018/03/30 22:19:06 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
if [[ $1 = "--help" ]] || [[ $1 = "--Help" ]] || [[ $1 = "--h" ]]; then
	printf "Usage: ./birds.sh <language>\n"
else
	printf "./birds.sh <--h> or <--help> or <--Help> for help\n"
	if [[ $1 != "C" ]] && [[ $1 != "c" ]] && [[ "$1" != *[a-z]* ]] &&
		[[ "$1" != *[A-Z]* ]]; then
		printf "Usage: ./birds.sh <language>\n"
	else
		check1=1
		while [ $check1 = 1 ]
		do
			read -p "Enter work directory path: " dir
			printf "\n"
			if [ -d "$dir" ]; then
				printf "Error: directory path already exists\n\n"
			else
				printf "Creating new directory\n\n"
				mkdir $dir
				check1=0
			fi
		done
		if [ ${#1} == 1 ] && [ "$1" = "c" ] || [ "$1" = "C" ]; then
			printf "Project language: C\n"
			cd $dir
			printf "Creating Makefile...\n"
			touch Makefile
			printf "NOTE: Makefile includes libft and mlx. Fix accordingly\n"
			echo "SRC = dot_c_file.c		\\

OBJ = \$(SRC:.c=.o)
MLX = -L \$(MLXDIR) -lmlx -framework OpenGL -framework Appkit

SRCDIR = srcs
OBJDIR = objs
LIBDIR = libs/libft
MLXDIR = libs/mlx

SRCS = \$(addprefix \$(SRCDIR)/, \$(SRC))
OBJS = \$(addprefix \$(OBJDIR)/, \$(OBJ))
LIBS = \$(LIBDIR)/libft.a \$(MLX)
HEADER = -I includes -I \$(LIBDIR)/includes -I \$(MLXDIR)

CC = gcc
CFLAGS = -c -Wall -Wextra -Werror

NAME = PROJECT_NAME

.PHONY: all clean fclean re
.SUFFIXES: .c .o

all: \$(NAME)

\$(OBJDIR)/%.o: \$(SRCDIR)/%.c
	@mkdir -p \$(OBJDIR)
	@\$(CC) \$(CFLAGS) \$(HEADER) $< -o \$@

\$(NAME): \$(OBJS)
	@make -C \$(MLXDIR)
	@make -C \$(LIBDIR)
	@\$(CC) \$(OBJS) \$(LIBS) -o \$@
	@echo \"\\\\033[1;32m[make - all] DONE\\\\033[0m\"

clean:
	@/bin/rm -rf \$(OBJDIR)
	@make -C \$(MLXDIR) clean
	@make -C \$(LIBDIR) clean
	@echo \"\\\\033[1;31m[make - clean] DONE\\\\033[0m\"

fclean: clean
	@/bin/rm -f \$(NAME)
	@rm -f \$(LIBDIR)/libft.a
	@echo \"\\\\033[1;31m[make - fclean] DONE\\\\033[0m\"

re: fclean all" > Makefile
			printf "Creating srcs, libs, and includes...\n"
			mkdir srcs includes libs
			# nothing
			printf "Creating .gitignore\n\n"
			touch .gitignore
			echo "# gitignore
.gitignore

# Object files
*.o

# Precompiled Headers
*.gch

# Libraries
*.a

# Executables
*.exe
*.out

# Debug files
*.dSYM/

### macOS ###
*.DS_Store
.AppleDouble
.LSOverride

# Thumbnails
._*

### Vim ###
# swap
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-v][a-z]
[._]sw[a-p]
# session
Session.vim
# temporary
.netrwhist
*~" > .gitignore
			read -n1 -p "clone your libft? [y/n] " ret
			echo ""
			if 	[ "$ret" = "y" ] || [ "$ret" = "Y" ]; then
				check2=1
				while [ $check2 = 1 ]
				do
					read -p "git repository for libft: " repo
					echo ""
					git clone $repo libs/libft
					if [ -d "libs/libft" ]; then
						check2=0
					fi
				done
			fi
		else
			printf "Project language: %s\n" "$1"
			cd $dir
			printf "Creating .gitignore\n"
			touch .gitignore
			echo "# gitignore
.gitignore

# Object files
*.o

# Precompiled Headers
*.gch

# Libraries
*.a

# Executables
*.exe
*.out

# Debug files
*.dSYM/

### macOS ###
*.DS_Store
.AppleDouble
.LSOverride

# Thumbnails
._*

### Vim ###
# swap
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-v][a-z]
[._]sw[a-p]
# session
Session.vim
# temporary
.netrwhist
*~" > .gitignore
		fi
	fi
fi
