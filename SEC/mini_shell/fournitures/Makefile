CC = gcc
CFLAGS = -Wall 
SOURCES = minishell.c Processus.c readcmd.c
OBJECTS = minishell.o Processus.o readcmd.o
EXEC = mini_shell
RM = rm

#Regles

all : $(EXEC)


$(EXEC) : $(OBJECTS)
			 $(CC) $(CFLAGS) -o $@ $^
		

		 
clean :
	   $(RM) *.o $(EXEC)
	 
depend :
		makedepend *.c -Y.$(SOURCES)




