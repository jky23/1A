#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/types.h>
#include <string.h>
#include "Processus.h"
#include "readcmd.h"


/**Ligne de commande à l'entrée**/
struct cmdline * cmd;
/**Identifiant shell **/ 
int nbre_tache = 0;
/**Référence de fork**/
int ref;
/**Référence chdir**/
int ch;
/**le parametre de la  fonction wait**/
int param; 
/** Le répertoire courant **/
char rep_courant[100];
/** Le pid **/
int pid ;
/** La liste de procedures **/
list_proc list_p;

/*****************************************************************/
/** Traitant des signaux */
/** Le signal SIGTSTP*/
void traitant_SIGTSTP(int sig) {
    kill(ref, SIGSTOP);
    /** Traitement de la suspension **/
    printf("\nLe processus est stoppé!!");
   
}

void traitant_SIGINT(int sig) {
    kill(ref, SIGKILL);
    /** Traitement de la suspension **/
    printf("\nLe processus est suicidé!!");
   
}

/** Le signal SIGCHLD **/
void traitant_SIGCHLD (int sig) {
  int etat_f, pid_f;
  do {
    pid_f = (int) waitpid(-1, &etat_f, WNOHANG | WUNTRACED | WCONTINUED);
    if(pid_f == -1) {
      perror("waitpid");
      exit(EXIT_FAILURE);
  } else if (pid_f > 0) {
	   if (WIFSTOPPED(etat_f)) {
		   /** Traitement de la suspension */
		   printf("Processus stoppé\n");
		   maj_etat(pid_f,&list_p,SUSPENDU);
	   } else if (WIFCONTINUED(etat_f)) {
			   /* Traiter la suspension */
			   printf("Processus redémarré\n");
			   maj_etat(pid_f,&list_p,ACTIF);
	   } else if (WIFEXITED(etat_f)) {
			   /* Traiter exit */
			   printf("Processus arrêté\n");
			   delete(pid_f,&list_p);
	   } else if (WIFSIGNALED(etat_f)) {
			   /* Traiter signal */
	   }
   }
} while (pid_f > 0) ;
	}

/*******************************************************************/		
/** Redirections de l'entrée **/
void redir_entree(struct cmdline * cmnd) {
  int d;
  if (cmnd -> in != NULL) {
    d = open(cmnd->in,O_RDONLY);
    if(d == -1) {
      perror("Ouvert");
    }
    if(dup2(d,0) == -1) {
      perror("dup2");
      exit(2);
    }
    if(close(d) == -1) {
      perror("Fermé");
      exit(3);
    }
  }
}

/** Redirections de la sortie **/		   

void redir_sortie(struct cmdline * cmnd) {
  int d;
  if (cmnd -> out != NULL) {
    d = open(cmnd->out,O_WRONLY | O_CREAT |O_TRUNC, 0644);
    if(d == -1) {
      perror("open");
    }
    if(dup2(d,1) == -1) {
      perror("dup2");
      exit(4);
    }
    if(close(d) == -1) {
      perror("close");
      exit(5);
    }
  }
}

/******************************************************************/
/** Commandes internes du shell **/
/** Lecture d'une commande **/
void lire_commande() {
        do{
	  strcpy(rep_courant, getcwd(NULL, 0));
	  printf("\n%s ", rep_courant);
	  printf(" > ");
	  cmd = readcmd();
	}while(cmd->seq[0] == NULL);
}

/**La commande cd*/
void cd(struct cmdline *cmd) {
   if (cmd->seq[0][1] == NULL && rep_courant != getenv("HOME")) {
                strcpy(rep_courant, getenv("HOME"));
                chdir(rep_courant);
            } else {
                ch = chdir(cmd->seq[0][1]);
                if (ch == 0) {
                    strcpy(rep_courant, getcwd(NULL, 0));
                } else {
                    printf("Erreur d'exectution\n");
                }
           }
}


/** La commande stop **/
void stop (struct cmdline *cmd) {
  int nbre_Com = atoi(cmd->seq[0][1]);
  pid= find_pid(nbre_Com,list_p);
  kill(pid,SIGSTOP);
  maj_etat (nbre_Com , list_p , SUSPENDU);
}


/** La commande bg **/
void bg (struct cmdline *cmd) {
  int nbre_Com = atoi(cmd->seq[0][1]);
  pid= find_pid(nbre_Com,list_p);
  kill(pid,SIGCONT);
  delete(pid,&list_p);
  mettre_a_jour(list_p);  
}


/** La commande fg **/
void fg (struct cmdline *cmd) {
  int nbre_Com = atoi(cmd->seq[0][1]);
  pid= find_pid(nbre_Com,list_p);
  waitpid(pid,&param,0);
  mettre_a_jour (list_p);
}

/** Nombre de commandes **/
int nbre_Com(struct cmdline *cmnd) {
  int q = 0;
  while(cmd ->seq[q] != NULL) {
    q++;
  }
  return q;
}


/***************************************************************************/
/** Programme principal **/
int main() {

    /** La liste de procedures **/
    list_p= nouvelle_liste();
    /** Descripteur pipe **/
    int p1[2];


    /** Masquage des signaux */
    chdir(getenv("HOME"));
    signal(SIGINT,traitant_SIGINT); // a revoir
    signal(SIGTSTP,traitant_SIGTSTP); // a revoir


   /** Boucle while (Boucle infinie) **/
    while (1) {

        /**	Lecture de la commande **/
      lire_commande();
      
        /**Commande exit**/
        if (strcmp(cmd->seq[0][0], "exit") == 0) {
            exit(0);
	
	   /**Commande cd**/
        } else if (strcmp(cmd->seq[0][0], "cd") == 0) {
            cd(cmd); 	 	
	    
	   /**Commande jobs**/
	    } else if (strcmp(cmd->seq[0][0],"jobs")== 0) {
	    afficher(list_p);
	 
	   /**Commande stop*/
        }else if (strcmp(cmd->seq[0][0], "stop") == 0){
            stop(cmd);
       
       /**Commande fg*/
		}else if (strcmp(cmd->seq[0][0], "fg") == 0){
			fg(cmd);
		
		/** Commande bg*/
		}else if (strcmp(cmd->seq[0][0], "bg") == 0){
			bg(cmd);
		 
		}else {
			/** Commandes externes du shell **/ 
            /**Créer fils**/
            ref = fork();
            
            if (ref == -1) {
                perror("\nErreur liée à l'éxécution de fork\n");
                exit(1);
			} else if ( ref == 0) {
				/** Fils crée **/
				nbre_tache++;
				add_tete(nbre_tache,ref,ACTIF,cmd->seq[0],&list_p);
				
				/** 2 commandes **/
				if (nbre_Com(cmd) == 2) {
					int p = pipe(p1); //p1 descripteur pipe
					if (p == -1) {
						perror("Erreur pipe");
						exit(1);
					} else {
						int ref1 = fork();
						if (ref1 == -1) {
							perror("Erreur fork");
							exit(1);
						} else if (ref1 == 0) {
							close(p1[1]); // a revoir
							int a = 0;
							while((cmd->seq)[0][a] != NULL) {
								read(p1[0], (cmd->seq)[0][a], sizeof((cmd->seq)[0][a]));
								a++;
							}
							int ex = execvp((cmd->seq)[0][0],(cmd->seq)[0]);
							if (ex == -1) {
								perror("Erreur exec");
								exit(1);
							}
							else {
								
							}
							
						} else {
							close(p1[0]); // a revoir
							int a = 0;
							while ((cmd->seq)[0][a] != NULL) {
								write(p1[1], (cmd->seq)[0][a], sizeof((cmd->seq)[0][a]));
								a++;
							}
							
						
						}
					}
				} else if (nbre_Com(cmd) == 1) {
					/**Redirections **/
					redir_entree(cmd);
					redir_sortie(cmd);
					/** Execution de la commande externe **/
					int ex = execvp((cmd->seq)[0][0], (cmd->seq)[0]);
					if (ex == -1) {
						perror("Exec");
						exit(3);
					} else {
						nbre_tache++;
						add_tete(nbre_tache,ref,ACTIF,cmd->seq[0],&list_p);
						continue;
					}
								
					
				}
			} else {
				/** Processus pere on attend la fin des processus fils **/
                if (cmd->backgrounded == NULL) {
					/** Le processus pere attend la fin des processus fils **/
                    pause(); //faire un pause plutot
                } else {
					/** Le processus père peut donner la main à un autre processus **/
					//wait(&param);
					continue;
				}
			}
		}
	}
    return (EXIT_SUCCESS);

}
//Utiliser plutot sigaction que signal
//Pour la commande jobs utiliser un module de liste des processeurs
//Tester les codes d'erreurs de tous les appels systemes ( utiliser 
//surtout les perror et les exit apres le perror)
//Utiliser aussi un makefile





