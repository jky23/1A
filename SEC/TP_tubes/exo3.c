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
	int fd[2];
	int Noctets = 512;
	int buf = 12;
	int pid = fork();
	int  j = pipe(fd);
	if (j== -1) {
		printf("Erreur de creation du pipe");
	}
	if (pid != 0) {
		int w = write(fd[1],&buf,sizeof(buf));
		if (w==-1) {
			printf("Erreur sur l'écriture");
		}
	}
	else {
		int r = read(fd[0], &buf, sizeof(buf));
		if (r==-1) {
			printf("Erreur sur la lecture");
		}
	}
	return EXIT_SUCCESS;
 }
