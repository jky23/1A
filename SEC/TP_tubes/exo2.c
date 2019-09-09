#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <signal.h>
#include <fcntl.h>

#define STDINFILENO
#define STDOUTFILENO
#define STDERRFILENO
#define NULL ((void*)0)

/**Programme principal */
int main(int argc, char* argv[]) {
	if (argc<=2) {
		printf("Pas d'arguments");
	}
	int in = open(argv[1], O_RDONLY,0);
	if (in == -1) {
		printf("Erreur d'ouverture");
	}
	dup2(in,0);
	int out = open(argv[2], O_WRONLY|O_CREAT,0644);
	if (out == -1) {
		printf("erreur d'ouverture");
	}
	dup2(out, 1);
	exec("cat");
	return EXIT_SUCCESS;
}
	
