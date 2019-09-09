#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#include <ctype.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/time.h>

#define BUFSIZE 512
#define STDIN_FILENO 0
#define max(a,b) (a>=b?a:b)
void traiter(char tampon [], char cde, int nb) {

  int i;
  
  /* toupper, tolower, module string.h */
  switch(cde) {
    case 'X' :
      break;
    case 'Q' :
      exit(0);
      break;
    case 'R' :
      tampon[nb] = '\0';
      printf("%s", tampon);
      break;
    case 'M' :
      for (i=0; i < nb; i++) {
        tampon[i] = toupper(tampon[i]);
      }
      tampon[nb] = '\0';
      printf("%s", tampon);
      break;
    case 'm' :
      for (i=0; i < nb; i++) {
        tampon[i] = tolower(tampon[i]);
      }
      tampon[nb] = '\0';
      printf("%s", tampon);
      break;
    default :
      printf("????");
  }
  return;
}
int main (int argc, char *argv[]) {

  int p[2];
  pid_t pid;
  int d, nlus;
  char buf[BUFSIZE + 1];
  char commande = 'R'; /* mode normal */

  if (argc != 2) {
    printf("utilisation : %s <fichier source>\n", argv[0]);
    exit(1);
  }

  if (pipe(p) == -1) {
    perror ("pipe");
    exit(2);
  }

  pid = fork();
  if (pid == -1) {
    perror ("fork");
    exit(3);
  }

  if (pid == 0) {   /* fils  */

    d = open (argv[1], O_RDONLY);
    
    if (d == -1) {
      fprintf (stderr, "Impossible d'ouvrir le fichier ");
      perror (argv[1]);
      exit (4);
    }
    
    close(p[0]); /* pour finir malgre tout, avec sigpipe */
    
    while (1) {
      while ((nlus = read (d, buf, BUFSIZE)) > 0) {
        /* read peut lire moins que le nombre d'octets demandes, en
         * particulier lorsque la fin du fichier est atteinte. */
        write(p[1], buf, nlus);
        sleep(5);
      }
      sleep(5);
      printf("on recommence...\n");
      lseek(d, (off_t) 0, SEEK_SET);
    }

  } else {   /* pere */
	  fd_set fds;
    close(p[1]);

    system("stty -icanon min 1");

	/* a completer */
    while (commande != 'Q') {
		FD_ZERO(&fds);
		FD_SET(STDIN_FILENO,&fds);
		FD_SET(p[0], &fds);
        int sel = select(max(STDIN_FILENO, p[0]) +1, &fds,NULL, NULL,NULL);
        if(sel == -1) {
			perror("Erreur select");
			exit(1);
		}
		if (sel > 0) {
			if (FD_ISSET(STDIN_FILENO,&fds)) {
				nlus = read(STDIN_FILENO, &commande, sizeof(char));
			}
			else if (FD_ISSET(p[0], &fds)) {
				nlus = read(p[0], buf, BUFSIZE*sizeof(char));
				traiter(buf, commande, nlus);
			}
			traiter(buf, commande, nlus);
			
    	
        	
     //sleep(1);
    }
  }
  return 0;
}
}
