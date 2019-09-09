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
int ref,ref_1,ref_2;
/**Référence chdir**/
int ch;
/**le parametre de la  fonction wait**/
int param; 
/** Le répertoire courant **/
char rep_courant[100];
/** Le pid **/
int pid ;
/** La liste de procedures **/
Liste_process list_p;

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
		   maj_etat(pid_f,list_p,SUSPENDU);
	   } else if (WIFCONTINUED(etat_f)) {
			   /* Traiter la suspension */
			   printf("Processus redémarré\n");
			   maj_etat(pid_f,list_p,ACTIF);
	   } else if (WIFEXITED(etat_f) || (WIFSIGNALED(etat_f))) {
			   /* Traiter exit */
			   printf("Processus arrêté\n");
			   delete(pid_f,&list_p);
	   }
   }
} while (pid_f > 0) ;
	}
	
	
/** Ensemble des signaux a ignorer 
int signaux[2]={SIGINT,SIGTSTP};


 Creation des structures sigaction 
struct sigaction handlerSIGINT;
handlerSIGINT->sa_handler = &traitant_SIGINT;
handlerSIGINT->sa_flags = 0;
sigemptyset(&handlerSIGINT->sa_mask);
sigaddset(&(handlerSIGNINT->sa_mask),signaux[1]);
sigaddset(&(handlerSIGNINT->sa_mask),signaux[2]);
    
struct sigaction handlerTSTP;
handlerTSTP->sa_handler = &traitant_SIGTSTP;
handlerSIGTSTP->sa_flags = 0;
sigemptyset(&handlerSIGTSTP->sa_mask);
sigaddset(&(handlerSIGTSTP->sa_mask),signaux[1]);
sigaddset(&(handlerSIGTSTP->sa_mask),signaux[2]);
    
struct sigaction handlerSIGCHILD; 
handlerSIGCHILD->sa_handler = &traitant_SIGCHLD;
handlerSIGCHILD->sa_flags = 0;
**/	



/*******************************************************************/		
/** Redirections de l'entrée **/
void redir_entree(struct cmdline * cmnd) {
  int d;
  if (cmnd -> in != NULL) {
    d = open(cmnd->in,O_RDONLY);
    if(d == -1) {
      perror("Erreur ouverture");
    }
    if(dup2(d,0) == -1) {
      perror("Erreur duplication entrée");
      exit(2);
    }
    if(close(d) == -1) {
      perror("Erreur fermeture");
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
      perror("Erreur ouverture");
    }
    if(dup2(d,1) == -1) {
      perror("Erreur duplication sortie");
      exit(4);
    }
    if(close(d) == -1) {
      perror("Erreur fermeture");
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
                    printf("Erreur d'execution\n");
                }
           }
}


/** La commande stop **/
void stop (struct cmdline *cmd) {
  int nb_Com = atoi(cmd->seq[0][1]);
  if (list_p == NULL) {
	  printf("Pas de processus");
	  exit(1);
  }
  pid= find_pid(nb_Com,list_p);
  kill(pid,SIGSTOP);
  maj_etat (nb_Com , list_p , SUSPENDU);
}


/** La commande bg **/
void bg (struct cmdline *cmd) {
	if (list_p == NULL) {
	  printf("Pas de processus");
	  exit(1);
  }
  int nb_Com = atoi(cmd->seq[0][1]);
  pid= find_pid(nb_Com,list_p);
  kill(pid,SIGCONT);
  delete(pid,&list_p);
  mettre_a_jour(list_p);  
}


/** La commande fg **/
void fg (struct cmdline *cmd) {
	if (list_p == NULL) {
	  printf("Pas de processus");
	  exit(1);
  }
  int nb_Com = atoi(cmd->seq[0][1]);
  pid= find_pid(nb_Com,list_p);
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
    int p1[2], p2[2];
    
    
    chdir(getenv("HOME"));
   
    


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
				 signal(SIGINT,&traitant_SIGINT);
				 signal(SIGTSTP,&traitant_SIGTSTP);
				 signal(SIGCHLD,&traitant_SIGCHLD);
				
				/** Masquage de SIGINT et SIGTSTP
				int s1 = sigprocmask(SIG_BLOCK,&maskINT,NULL);
				if (s1 == -1) {
					perror("Erreur masquage");
					exit(1)
				}
				int s2 = sigprocmask(SIG_BLOCK,&maskTSTP,NULL);
				if (s2 == -1) {
					perror("Erreur masquage");
					exit(1)
				} **/
				
				/** 3 commandes **/
				if (nbre_Com(cmd) >= 3 ) {
					int p_1 = pipe(p1); // Creation du 1er pipe
					
					if (p_1 == -1) {   // Erreur pipe 1
						perror("Erreur pipe 1");
						exit(1);
					}
					ref_1 = fork();    // Creation du 1er fils
					if (ref_1 == -1) {
						perror("erreur fork 1");
						exit(1);
					} else if(ref_1 == 0) {
						// On se trouve dans le fils
						
						int p_2 = pipe(p2);  // Creation du 2e pipe
						if(p_2 == -1) {
							perror("Erreur pipe 2");
							exit(2);
						}
						ref_2 = fork();  // Creation du petit fils (fils du 1er fils)
						if (ref_2 == -1) {
							perror("Erreur fork 2");
							exit(2);
						} else if (ref_2 == 0) {
							/** On se trouve dans le petit fils **/
							//  Recuperer le contenu du pipe 2
							int d = dup2(p2[0],0); // a revoir
							if (d == -1) {
								perror("Erreur duplication sortie standard");
								exit(3);
							}
							
							// Fermeture des descripteurs superflus
							close(p2[1]);
							close(p1[0]);
							close(p2[0]);
							close(p1[1]);
							
							// On redirige la sortie vers un fichier eventuel entré en parametre
							redir_sortie(cmd);
							/** Recouvrement */
							int ex = execvp((cmd->seq)[2][0], (cmd->seq)[2]);
							if (ex == -1 ) {
								perror("Erreur Exec 2");
								exit(3);
							}
							nbre_tache++;
							add_tete(nbre_tache,ref_2,ACTIF,cmd->seq[2],&list_p);
							exit(4); // le petit fils se termine
						} else {
							// Recuperer le contenu du pipe 1	
							int d = dup2(p1[0],0);
							if (d == -1) {
								perror("Erreur duplication");
								exit(1);
							}
							// Transferer au pipe 2
							int d1 = dup2(p2[1],1);
							if (d1 == -1) {
								perror("Erreur duplication");
								exit(1);
							}
							// Le 1er fils ferme les descripteurs inutiles
							close(p1[1]);
							close(p1[0]);
							close(p2[1]);
							close(p2[0]);
							
							/** Execution de la commande **/
							int ex = execvp((cmd->seq)[1][0], (cmd->seq)[1]);
							if (ex == -1 ) {
									perror("Erreur Exec");
									exit(3);
							}
							nbre_tache++;
							add_tete(nbre_tache,ref_2,ACTIF,cmd->seq[1],&list_p);
							
							wait(NULL); // le fils attends que son fils se termine
							exit(4); // et se termine
						}
						
						
					} else {
						// On redirige l'entrée standard vers un fichier eventuel entré en parametre
						redir_entree(cmd);
						  
						// on redirige la sortie du pipe1 vers la sortie standard
						int d = dup2(p1[1],1);
						if (d == -1) {
							perror("Erreur duplication");
							exit(1);
						}
						// on ferme les descripteurs inutiles
						close(p1[0]);
						close(p1[1]);
						/** Execution de la commande externe **/
						int ex = execvp((cmd->seq)[0][0], (cmd->seq)[0]);
						if (ex == -1 ) {
									perror("Erreur Exec");
									exit(2);
						}
						nbre_tache++;
						add_tete(nbre_tache,ref_1,ACTIF,cmd->seq[0],&list_p);
						wait(NULL); // on attend la fin du fils
						exit(1); // et on se termine
						
					}
				}
				
				/** 2 commandes **/
				else if (nbre_Com(cmd) == 2) {
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
							
							int d = dup2(p1[0],0);
							close(p1[0]);
							if (d == -1) {
								perror("Erreur duplication");
								exit(1);
							}
							// On redirige la sortie standard vers un fichier eventuel entré en parametre
							redir_sortie(cmd);	
							/** Execution de la commande externe **/
							int ex = execvp((cmd->seq)[1][0], (cmd->seq)[1]);
							if (ex == -1 ) {
									perror("Erreur Exec 1");
									exit(3);
							}
							nbre_tache++;
							add_tete(nbre_tache,ref1,ACTIF,cmd->seq[0],&list_p);
							exit(4);
								
						} else {
							// On redirige l'entrée standard vers un fichier eventuel entré en parametre
							redir_entree(cmd);
							close(p1[0]); // a revoir
							
							int d = dup2(p1[1],1);
							close(p1[1]);
						
							if (d == -1) {
								perror("Erreur duplication");
								exit(1);
							}	
							/** Execution de la commande externe **/
							int ex = execvp((cmd->seq)[0][0], (cmd->seq)[0]);
							if (ex == -1) { 
									perror("Erreur Exec 0");
									exit(3);
							}
							
							nbre_tache++;
							add_tete(nbre_tache,ref1,ACTIF,cmd->seq[0],&list_p);
							wait(NULL);
							exit(5);
								
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
					}
					nbre_tache++;
					add_tete(nbre_tache,ref,ACTIF,cmd->seq[0],&list_p);
					exit(4);
										
				}
			} else {
				/** Processus pere on attend la fin des processus fils **/
                if (cmd->backgrounded == NULL) {
					/** Le processus pere attend la fin des processus fils **/
					nbre_tache++;
					add_tete(nbre_tache,ref,ACTIF,cmd->seq[0],&list_p);
                    wait(NULL); //faire un pause plutot
                    
                }
				/** Le processus père peut donner la main à un autre processus **/
			}
		}
	}
    return (EXIT_SUCCESS);

}





