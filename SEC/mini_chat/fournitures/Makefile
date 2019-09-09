CC = gcc
CFLAGS = -Wall 
SOURCES = console.c serveur.c chatmmap.c
#BJECTS = console.o serveur.o
EXEC = serveur console
RM = rm

#Regles




main : $(SOURCES)
		$(CC) $(CFLAGS) console.c -o console
		$(CC) $(CFLAGS) chatmmap.c -o chatmmap
		$(CC) $(CFLAGS) serveur.c -o serveur

		 
clean :
	  
	   $(RM) console 
	   $(RM) chatmmap
	   $(RM) serveur
	   $(RM) ecoute
	   $(RM) *_C2S
	   $(RM) *_S2C
	  
	 





