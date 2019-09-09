CC = c99
CFLAGS = -Wextra -c
LDFLAGS = -Wextra -g
EXEC = exemple_file test_file

all : $(EXEC)
    
exemple_file : exemple_file.o file.o
				  $(CC) $(LDFLAGS) -o $@ $^
				  
test_file : test_file.o file.o
				$(CC) $(LDFLAGS) -o $@ $^
	
depend :
	        makedepend -Y *.c
	        
clean : 
		   rm *.o $(EXEC)
