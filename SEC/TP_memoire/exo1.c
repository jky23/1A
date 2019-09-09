#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>

void garnir(char zone[], int lg, char motif) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		zone[ind] = motif ;
	}
}

void lister(char zone[], int lg) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		printf("%c",zone[ind]);
	}
	printf("\n");
}

int main(int argc,char *argv[]) {
	int taillepage = sysconf(_SC_PAGESIZE);
	//const char *nomf = 'toto';
	char *buf = malloc(2*taillepage*sizeof(char));
	
	int fd = open(argv[1], O_WRONLY|O_CREAT, 0600);
	
	if (fd == -1) {
		perror("Erreur d'ouverture");
		exit(1);
	}
	
	garnir(buf, 2*taillepage,'a');
	int a = write(fd, buf, 2*taillepage);
	
	if (a == -1) {
		perror("Erreur d'ecriture");
		exit(1);
	}
	
	close(fd);
	int fg = open(argv[1], O_RDWR);
	
	if (fg == -1) {
		perror("Erreur d'ouverture2");
		exit(1);
	}
	
	off_t offset = taillepage;
	char *zone_mem = mmap(NULL, 2*taillepage, PROT_READ|PROT_WRITE, MAP_SHARED, fg, 0);
	if (zone_mem == MAP_FAILED) {
		perror("Echec couplage");
		exit(1);
	}
	
	
	int pid_f = fork();
	if (pid_f == -1) {
		perror("Erreur fork");
		exit(1);
	} else if (pid_f == 0) {
		int sommeil = 2;
		sleep(sommeil);
		lister(zone_mem, 10);
		lister(&zone_mem[taillepage],10);
		garnir(zone_mem, taillepage, 'c');
		exit(0);
	} else {
		garnir(&zone_mem[taillepage], taillepage, 'b');
		wait(NULL);
		lister(&zone_mem[taillepage],10);
		exit(0);
	}
	return EXIT_SUCCESS;
		
	
	
	
	
	

}
