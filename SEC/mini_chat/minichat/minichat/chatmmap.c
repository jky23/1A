/* version 0.1 (PM, 23/4/17) :
	La discussion est un tableau de messages, couplé en mémoire partagée.
	Un message comporte un auteur, un texte et un numéro d'ordre (croissant).
	Le numéro d'ordre permet à chaque participant de détecter si la discussion a évolué
	depuis la dernière fois qu'il l'a affichée.
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h> /* définit mmap  */
#include <signal.h>

#define TAILLE_AUTEUR 25
#define TAILLE_TEXTE 128
#define NB_LIGNES 20

/* message : numéro d'ordre, auteur (25 caractères max), texte (128 caractères max) */
struct message {
  int numero;
  char auteur [TAILLE_AUTEUR];
  char texte [TAILLE_TEXTE];
};

/* discussion (20 derniers messages) */
struct message * discussion;

/* dernier message reçu */
int dernier0 = 0 ;

/* afficher la discussion */
void afficher() {
	int i;
	for (i=0; i<NB_LIGNES; i++) {
		printf("[%s] : %s\n", discussion[i].auteur, discussion[i].texte);
	}
	printf("=========================================================================\n");
}

/* traitant : rafraichir la discussion, s'il y a lieu */
void traitant (struct message m) {
  int i;
  m.numero = (discussion[NB_LIGNES-1].numero) + 1;
  for (i=0; i<(NB_LIGNES-1); i++) {
    discussion[i]=discussion[i+1];
  }
  discussion[NB_LIGNES-1] = m;
}

int main (int argc, char *argv[]) { 
	struct message m;
	int i,taille,fdisc;
 	char qq [1];
 	FILE * fdf;
	
	if (argc != 3) {
		printf("usage: %s <discussion> <participant>\n", argv[0]);
		exit(1);
	}

	 /* ouvrir et coupler discussion */
	if ((fdisc = open (argv[1], O_RDWR | O_CREAT, 0666)) < 0) {
		printf("erreur ouverture discussion\n");
		exit(2);
	}
	
	/*	mmap ne spécifie pas quel est le resultat d'une ecriture *apres* la fin d'un 
		fichier couple (SIGBUS est une possibilite, frequente). Il faut donc fixer la 
		taille du fichier destination à la taille du fichier source *avant* le couplage. 
		On utilise ici lseek (a la taille du fichier source) + write d'un octet, 
		qui sont deja connus.
	*/
	qq[0]='x';
	taille = sizeof(struct message)*NB_LIGNES;
 	lseek (fdisc, taille, SEEK_SET);
 	write (fdisc, qq, 1);
 	
 	/* à compléter : saisie des messages, gestion de la discussion*/
	discussion = mmap(NULL, taille, PROT_READ|PROT_WRITE, MAP_SHARED, fdisc, 0);
	if (discussion==MAP_FAILED) {
	  printf("map failed \n");
          exit(1);
	}
        discussion[0].numero = 0;
        while (1) {
          bzero(m.texte, TAILLE_TEXTE);
          if (read(0, m.texte, TAILLE_TEXTE) > 0) {
             traitant(m);
             afficher();
             dernier0 = m.numero;
          }
        }
 	
	close(fdisc);
 	exit(0);
}
