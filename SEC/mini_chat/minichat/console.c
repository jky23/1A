/* version 0 (PM, 16/4/17) :
	Le client de conversation
	- crée deux tubes (fifo) d'E/S, nommés par le nom du client, suffixés par _C2S/_S2C
	- demande sa connexion via le tube d'écoute du serveur (nom supposé connu),
		 en fournissant le pseudo choisi (max TAILLE_NOM caractères)
	- attend la réponse du serveur sur son tube _C2S
	- effectue une boucle : lecture sur clavier/S2C.
	- sort de la boucle si la saisie au clavier est "au revoir"
	Protocole
	- les échanges par les tubes se font par blocs de taille fixe TAILLE_MSG,
	- le texte émis via C2S est préfixé par "[pseudo] ", et tronqué à TAILLE_MSG caractères
Notes :
	-le  client de pseudo "fin" n'entre pas dans la boucle : il permet juste d'arrêter 
		proprement la conversation.
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>

#define TAILLE_MSG 128		/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25		/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1  /* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_TUBE 512		/*capacité d'un tube */
#define NB_LIGNES 20
#define TAILLE_SAISIE 1024

char pseudo [TAILLE_NOM];
char buf [TAILLE_TUBE];
char discussion [NB_LIGNES] [TAILLE_MSG]; /* derniers messages reçus */

void afficher(int depart) {
    int i;
    for (i=1; i<=NB_LIGNES; i++) {
        printf("%s\n", discussion[(depart+i)%NB_LIGNES]);
    }
    printf("=========================================================================\n");
}

int main (int argc, char *argv[]) {
    int i,nlus,necrits;
    char * buf0; 					/* pour parcourir le contenu d'un tube */

    int ecoute, S2C, C2S;			/* descripteurs tubes */
    int curseur = 0;				/* position dernière ligne reçue */

    fd_set readfds; 				/* ensemble de descripteurs écoutés par le select */

    char tubeC2S [TAILLE_NOM+5];	/* pour le nom du tube C2S */
    char tubeS2C [TAILLE_NOM+5];	/* pour le nom du tube S2C */
    char pseudo [TAILLE_NOM];
    char message [TAILLE_MSG];
    char saisie [TAILLE_SAISIE];

    if (!((argc == 2) && (strlen(argv[1]) < TAILLE_NOM*sizeof(char)))) {
        printf("utilisation : %s <pseudo>\n", argv[0]);
        printf("Le pseudo ne doit pas dépasser 25 caractères\n");
        exit(1);
    }

    /* On copie l'argument de commande dans le pseudo */
    strcpy(pseudo, argv[1]);

    /* ouverture du tube d'écoute */
    ecoute = open("./ecoute",O_WRONLY);
    if (ecoute==-1) {
        printf("Le serveur doit être lance, et depuis le meme repertoire que le client\n");
        exit(2);
    }  
      
    /* création des tubes de service */
    sprintf(tubeC2S, "%s_C2S", pseudo);
    sprintf(tubeS2C, "%s_S2C", pseudo);

    /* Création des tubes nommés en accès écriture et lecture */
    mkfifo(tubeC2S, 0600);
    mkfifo(tubeS2C, 0600);
  
    /* On envoie le pseudo au serveur */
    write(ecoute, pseudo, strlen(pseudo)+1);
    
    /* Ouverture des tubes */
    if ((C2S = open(tubeC2S, O_WRONLY)) < 0){
      perror("open C2S");
      exit(3);
    }
    if ((S2C = open(tubeS2C, O_RDONLY)) < 0){
      perror("open S2C");
      exit(4);
    }
    
    if(strcmp(pseudo,"fin") != 0){
      /* client " normal " */
      strcpy(saisie, "");	
        while (strcmp(saisie,"au revoir\n") != 0) {
    
	  /* Préparation au select a suivre */
          FD_ZERO(&readfds);
          FD_SET(S2C, &readfds);
          FD_SET(0, &readfds);
	  i = select(NBDESC, &readfds, NULL, NULL, NULL);
          if (i > 0) {
	    /* Si un canal est prêt */
	    if (FD_ISSET(S2C, &readfds)) {
              bzero(message, TAILLE_MSG);
	      /* Lecture du message */
	      if ((read(S2C, message, TAILLE_MSG)) < 0) {
		perror("deconnexion serveur");
	      } else {
		/* Affichage du message */
                strcpy(discussion[curseur], message);
		afficher(curseur);
		/* Positionner le curseur */
		if(curseur < NB_LIGNES){
                  curseur++;
		} else {
		  curseur = 0;
		}
	      }
	    }
	    /* Si l'écran est prêt */
            if (FD_ISSET(0, &readfds)) {
              /* transmission du message au serveur */
              bzero(message, TAILLE_MSG);
              bzero(saisie, TAILLE_SAISIE);
              read(0, saisie, TAILLE_SAISIE);
              sprintf(message, "[%s] %s", pseudo, saisie);
              write(C2S, message, TAILLE_MSG);
            }
          }
        }
    }

    /* nettoyage */
    unlink(tubeC2S);
    unlink(tubeS2C);
    printf("fin client\n");
    exit (0);
}
