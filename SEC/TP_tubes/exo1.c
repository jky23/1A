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
	char* arg_ls[] = {"ls", "/bin/bash", NULL};
	int o = open(argv[1], O_WRONLY|O_CREAT, 0644);
	if (o == -1) {
		printf("Erreur d'ouverture");
	}
	int j = dup2(o, 1);
	execvp("ls", arg_ls);
	
	return EXIT_FAILURE;
}
