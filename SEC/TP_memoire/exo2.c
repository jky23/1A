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
	char *buf = malloc(3*taillepage*sizeof(char));
	
	int fd = open(argv[1], O_WRONLY|O_CREAT, 0600);
	
	if (fd == -1) {
		perror("Erreur d'ouverture");
		exit(1);
	}
	
	garnir(buf, 3*taillepage,'a');
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
	char *zone_mem = mmap(NULL, 3*taillepage, PROT_READ|PROT_WRITE, MAP_SHARED, fg, 0);
	if (zone_mem == MAP_FAILED) {
		perror("Echec couplage");
		exit(1);
	}
	
	
	int pid_f = fork();
	if (pid_f == -1) {
		perror("Erreur fork");
		exit(1);
	} else if (pid_f == 0) {
		munmap(zone_mem, taillepage * 2);
		char *zone_memfils = mmap(NULL, 3*taillepage, PROT_READ|PROT_WRITE, MAP_PRIVATE, fg, 0);
		if (zone_memfils == MAP_FAILED) {
			perror("Echec couplage fils");
			exit(1);
		}
		lister(zone_memfils, 10);
		sleep(4);
		write(1, zone_memfils, 10);
		write(1, "\n", 1);
		write(1, &zone_memfils[taillepage], 10);
		write(1, "\n", 1);
		write(1, &zone_memfils[taillepage*2], 10);
		write(1, "\n", 1);
/*		lister(zone_memfils,10);
		lister(&zone_memfils[taillepage],10);
		lister(&zone_memfils[2*taillepage],10);*/
		garnir(&zone_memfils[taillepage], taillepage, 'd');
		sleep(8);
		write(1, zone_memfils, 10);
		write(1, "\n", 1);
		write(1, &zone_memfils[taillepage], 10);
		write(1, "\n", 1);
		write(1, &zone_memfils[taillepage*2], 10);
		write(1, "\n", 1);
		/*lister(zone_memfils,10);
		lister(&zone_memfils[taillepage],10);
		lister(&zone_memfils[2*taillepage],10);*/
		
		return(0);
	} else {
		sleep(1);
		
		garnir(zone_mem, taillepage, 'b');
		garnir(&zone_mem[taillepage], taillepage, 'b');
		
		sleep(6);
		garnir(&zone_mem[taillepage], taillepage, 'c');
		
		return(0);
	}
	return EXIT_SUCCESS;
		
	
	
	
	
	

}
