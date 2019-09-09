#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main (int ar, char* args[]) {
	//int flag = 0;
	//const char nomf = '/coucou.txt';
	int a = open(args[1], O_RDONLY);
	printf("%d",a);
	if (a == -1) {
		perror("Entree de la copie");
		//return 1;
	}
	
	int b = open(args[1], O_WRONLY,S_IRUSR|S_IWUSR);
	if (b == -1) {
		perror("fichier non existant");
		return 1;
	}
	printf("%d",b);
	return EXIT_SUCCESS;
}
