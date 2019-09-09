#ifndef _PROCESSUS

  #define _PROCESSUS

  typedef enum {ACTIF, SUSPENDU} Etat;
  typedef struct fiche_proc *Liste_process;

#endif



/** Sémantique : Une fonction qui retourne une nouvelle liste de processus
 * Paramètres : pas des paramètres
 * Résultat : une nouvelle liste de processus vide qu'on nomme Liste_process
 * Pré conditions et post conditions: aucunes
 **/
Liste_process nouvelle_liste();



/** Sémantique : Une fonction qui ajoute un nouveau processus à Liste_process
 * paramètres : - int (D) : numéro du nouveau processus 
 *              - Etat (D) état du nouveau processus 
 *              - Liste _proc * (D/R) adresse de la liste de processus 
 * Résultat : 0 si l'ajout est réussi, 404 sinon
 * Pré-conditions : pas de processus courant (pas de doublon)
 * Post-conditions : Liste_process n'est plus vide
 **/
int add_tete(int nbre_Com, int pid, Etat e,char **comd, Liste_process *l);



/** Sémantique : Une procédure qui sert à afficher la liste de processus Liste_process
 * paramètres : Liste_process (D) : la liste de processus qu'on va afficher
 * Pré conditions et post conditions: aucunes
 **/
void afficher(Liste_process l) ;



/** Sémantique (Procédure):Elle sert à changer l'état de toutes les processus de la liste
 * Paramètres: Liste_process (D), la fonction de changement d'état
 *Pré conditions et post conditions: aucunes
 */
void changer_etat(Liste_process l, Etat (*fe)(Etat));



/**Sémantique : (fonction) : supprimer un processus d'une liste de processus
 * Paramètres : - : int  (D) numéro du processus à supprimer 
 *              - Liste_process * (D/R) adresse de la liste de processus
 * Résultat : 0 si la suppression est validée, 404 sinon (liste vide ou
 *            processus non présent)
 * Pré conditions : aucunes
 * Post conditions : le processus portant ce numéro n'est plus dans la liste 
 **/
int delete(int pid, Liste_process *l);



/**Sémantique : trouver l'élément correspondant au nombre des commandes nbre_Com donnée en paramètre (fonction)
 * Paramètres: -  int (D) nombre de commande
 *             - Liste_process (D) liste de processus 
 * Résultat : int le pid correspondant u nbre_Com
 * Pré conditions et post conditions: aucunes
 **/
int find_pid(int nbre_Com,Liste_process l);



/**Sémantique : (procédure) mettre à jour l'état du processus
 * Paramètres:(Liste_process)(D/R) une liste
 *            entier (D) : s_pid
 *            Etat : new_etat : le nouveau état du processus
 * Pré conditions: aucunes
 * post conditions :l'état du processus est mis à jour
 **/
int maj_etat (int s_pid, Liste_process l, Etat new_etat);



/**Sémantique : (procédure) mettre à jour nbre_Com
 * Paramètres:(Liste_process)(D/R) une liste
 * Pré conditions: aucunes
 * post conditions :le nombre de commandes est mis à jour
 **/
void mettre_a_jour(Liste_process l);
