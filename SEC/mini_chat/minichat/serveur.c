/* version 0 (PM, 16/4/17) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : 
		* accepter les demandes de connexion tube d'écoute) de nouveau(x) participant(s)
			 si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis 
				dans la demande de connexion
		* messages des tubes (fifo) de service en entrée 
			-> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine à la connexion d'un client de pseudo "fin"
	Protocole
	- suppose que les clients ont créé les tube d'entrée/sortie avant
		la demande de connexion, nommés par le nom du client, suffixés par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant.
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include <stdbool.h>
#include <sys/stat.h>

#define NBPARTICIPANTS 5 	/* seuil au delà duquel la prise en compte de nouvelles
								 connexions sera différée */
#define TAILLE_MSG 128		/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25		/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1	/* pour un select éventuel
								 (macros non definies si >= FD_SETSIZE) */
#define TAILLE_TUBE 512		/*capacité d'un tube */

typedef struct ptp {
    bool actif;
    char nom [TAILLE_NOM];
    int in;		/* tube d'entrée */
    int out;	/* tube de sortie */
} participant;

typedef struct dde {
    char nom [TAILLE_NOM];
} demande;

static const int maxParticipants = NBPARTICIPANTS+1+TAILLE_TUBE/sizeof(demande);

participant participants [NBPARTICIPANTS+1+TAILLE_TUBE/sizeof(demande)]; //maxParticipants
char buf[TAILLE_TUBE];
int nbactifs = 0;

void effacer(int i) {
  /* Actualiser la structure participants */
  participants[i].actif = false;
  bzero(participants[i].nom, TAILLE_NOM);
  participants[i].in = -1;
  participants[i].out = -1;
}

void diffuser(char *message) {
  int i;
  /* Pour chaque participants actifs */
  for(i=1;i<=nbactifs;i++){
    /* On transmet le message */
    write(participants[i].out,message,TAILLE_MSG);
  }
}

void desactiver (int p) {
  /* Fermer les tubes */
  close(participants[p].in);
  close(participants[p].out);

  /* Effacer le participant */
  effacer(p);

  /* Signaler sa disparition */
  //diffuser("[%s] a quitté la conversation.\n",participants[p].nom);		//Erreur de compilation...

  /* On retranche 1 au nombre de particpants actifs */
  nbactifs--;

  /* On actualise l'indice des participants */
  if (p != nbactifs) {
    participants[p] = participants[nbactifs];
  }
}

void ajouter(char *dep) {
/*  Pré : nbactifs < maxParticpants
	
	Ajoute un nouveau participant de pseudo dep.
	Si le participant est "fin", termine le serveur.
	
*/  
  int C2S, S2C;
  char tubeC2S[TAILLE_NOM+5];
  char tubeS2C[TAILLE_NOM+5];
  char err_msg[80];
  

  /* Création des tubes nommés */
  sprintf(tubeC2S, "%s_C2S", dep);
  sprintf(tubeS2C, "%s_S2C", dep);

  /* Ouverture des tubes nommés */
  if ((C2S = open(tubeC2S, O_RDONLY)) < 0){		//Tube cient vers serveur
    sprintf(err_msg, "open C2S: %s\n", tubeC2S);
    perror(err_msg);
    exit(1);
  }
  if ((S2C = open(tubeS2C, O_WRONLY, 0666)) < 0){		//Tube serveur vers client
    sprintf(err_msg, "open S2C: %s\n", tubeS2C);
    perror(err_msg);
    exit(4);
  }

  /* Actualiser la structure participants */
  participants[nbactifs].actif = true;
  strcpy(participants[nbactifs].nom, dep);
  participants[nbactifs].in = C2S;
  participants[nbactifs].out = S2C;

  /* On augment le nombre de participants de 1*/
  nbactifs++;


}

int main (int argc, char *argv[]) {
    int i,nlus,necrits,res;
    int ecoute;		/* descripteur d'écoute */
    fd_set readfds; /* ensemble de descripteurs écoutés par un select éventuel */
    char * buf0;   /* pour parcourir le contenu d'un tube, si besoin */
    demande dem;	// Structure de demande
    char pseudo[TAILLE_NOM];	// Pseudo entré

    /* création (puis ouverture) du tube d'écoute */
    mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
    ecoute=open("./ecoute",O_RDONLY);

    /* Reset du serveur */
    for (i=0; i<maxParticipants; i++) {
        effacer(i);
    }

    while (true) {
        printf("participants actifs : %d\n",nbactifs);
		/* boucle du serveur : traiter les requêtes en attente 
			sur le tube d'écoute et les tubes d'entrée
		*/
	/* Initialisation du tube nommé d'écoute */
	FD_ZERO(&readfds);
        FD_SET(ecoute, &readfds);

	/* Pour chaque participant actif : on rend prêt l'écouteur */
        for (i=0; i<nbactifs; i++) {
	  FD_SET(participants[i].in, &readfds);
        }
	
	/* Ecouter les file descriptor */
	res= select(NBDESC, &readfds, NULL, NULL, NULL);

	if (res > 0) {

	  /* On transfert les messages aux clients */
	  for (i=0; i<nbactifs; i++) {
	    /* Si on a reçu un message d'un client */
	    if (FD_ISSET(participants[i].in, &readfds)) {
	      bzero(buf,TAILLE_TUBE);
		/* On lit ce message */
		if (read(participants[i].in, buf, TAILLE_TUBE) < 0) {
		  perror("Lecture de message client");
		  exit(6);
		} else {
		  diffuser(buf);
		}
	    }
	  }
	  
	  /* Si le tube ecoute a reçu un message */
	  if (FD_ISSET(ecoute, &readfds)) {
	    bzero(pseudo,TAILLE_NOM);
	    /* Gestion des nouveaux participants */
	    if (nbactifs < maxParticipants) {
	      /* On lit ce qu'on reçoit sur le tube d'écoute */
	      if (read(ecoute, pseudo, TAILLE_NOM) < 0) {
		perror("Fin de conversation\n");
		exit(4);
	      } else {
		/* Si on n'a pas d'erreur de lecture */
		/* Si on reçoit Fin : on termine la conversation */
		if (strcmp(pseudo, "fin") == 0) {
		  printf("Terminaison de la conversation.\n"); 
		  exit(3);
		  } else {
	        /* Sinon on ajoute le participant */
                ajouter(pseudo);
                printf("%s a rejoint la conversation.\n",pseudo);
	        }
              }
	    } else {
	      /* Si le chat est plein, on notifie l'utilisateur */
	      printf("Le chat est plein, veuillez patienter.\n");
	    }
	  }
	  
	}
    }
    
    /* nettoyage */
    /*close(ecoute);
    unlink("./ecoute");*/
    return 0;
}
