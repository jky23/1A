#include <stdio.h>
#include <malloc.h>
#include "Processus.h"

/** Définition du type**/
struct fiche_proc {
   int nbreCom;
   int pid;
   Etat e;
   char **comd;
   Liste_process next;
};

/**Création d'nouvelle liste **/
Liste_process nouvelle_liste(){
  return NULL;
}

/**Ajouter un element en tête d'une chaîne**/
int add_tete(int nbreCom,int pid, Etat e,char **comd, Liste_process *l){
  int sub ;
   Liste_process nv = (Liste_process) malloc(sizeof(struct fiche_proc)) ;
   if( nv != NULL) {
     nv -> nbreCom = nbreCom;
     nv -> pid = pid;
     nv -> e = e;
     nv -> comd = comd;
     nv ->next = *l;
     *l=nv;
     sub = 0; }
   else {
     sub = 1;}
   return sub ;
}

/**Affichage d'une liste**/
void afficher(Liste_process l) {
	
  if(l==NULL) {
    printf("\n ** liste vide ** \n");
  }
  else {
    printf("\n **Début de la liste ** \n");
    while(l != NULL) {
      printf("%d   ", l->nbreCom);
      printf("%d   ", l->pid);

      printf("%s  ", l->comd[0]);
      if(l -> e == SUSPENDU) {
	printf("SUSPENDU \n");
      } else {
	printf("ACTIF \n");
      }
      l = l-> next;
    }
    printf("** Fin de la liste ** \n");
  }
 return;
 }

/**Appliquer une fonction sur le procesus **/

void changer_etat(Liste_process l, Etat (*fe)(Etat)) {
	/**Parametres**/
    Liste_process list ;
    list =l;
    while (list != NULL){
      list->e = fe( list -> e);
    list =list -> next ;}
    return;
    }

/** Supprimer une procesus de Liste_process **/ 

int delete(int pid, Liste_process *l){
	/**Parametres**/

	int sub ;
	Liste_process precedents;
	Liste_process courants;
  


	if ( *l == NULL) 
	{sub=1;}
	else{
	courants= *l;
    precedents= *l;
    while (courants != NULL && (courants->pid) != pid)
    {
      precedents=courants;
      courants=courants->next;
    }
    if ( courants == NULL)
    {
      sub=1;
    }
    else
    { 
      if (courants == *l){
	*l= (*l)->next;
      } else {
        precedents->next =courants->next;
      }
       free(courants);
       sub=0;
    }
  }
  return sub ;}
  


/** Trouver un certain pid dans la liste de processus Liste_process **/
int find_pid(int nbre_Com, Liste_process l) {
  Liste_process elem_Cour;
  /**Initialisation de l'elmnt courant**/
  elem_Cour = l;
  while((elem_Cour != NULL) && (elem_Cour->nbreCom != nbre_Com)){
    elem_Cour=elem_Cour->next;
  }
  return (elem_Cour->pid);
}



/**Mettre à jour l'etat d'un processus*/
int maj_etat (int s_pid, Liste_process l, Etat new_etat){
  Liste_process elem_Cour;
  elem_Cour = l;
  while((elem_Cour != NULL) && (elem_Cour-> pid != s_pid)){
      elem_Cour=elem_Cour->next;
  }
  if (elem_Cour == NULL ){
      return 404;}
  elem_Cour -> e = new_etat;
  return 0;
}



/** Mettre à jour le nombre de commandes de Liste_process*/
void mettre_a_jour(Liste_process l) {
  Liste_process pcour;
  pcour=l;
  while(pcour != NULL) {
    pcour->nbreCom = (pcour->nbreCom )-1;
    pcour=pcour->next;
  }
}



