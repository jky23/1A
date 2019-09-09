/**
 *  \author 
 *  \file
 *
 *  Implantation des op�rations de la file.
 */

#include <malloc.h>
#include <assert.h>

#include "file.h"



void initialiser(File *f)
{
	f->tete = NULL;
	f->queue = NULL; 
	assert(est_vide(*f));
}


void detruire(File *f)
{
	while (f->queue != NULL) 
	{
		suivant = f->queue->suivante;
		free(f->queue);
		f->queue = suivant;
	}
	free(f);
	f = NULL;
}


char tete(File f)
{
	assert(! est_vide(f));
	return f->tete->valeur;
}


bool est_vide(File f)
{
	return (f==NULL);
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis�es.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
	cellule = malloc(sizeof(*cellule));
	cellule->valeur = valeur;
	cellule->suivante = suivante;
	return cellule;
}

void inserer(File *f, char v)
{
	assert(f != NULL);
	suivant = cellule(v,f->queue);
	f->queue = suivant;
	if (f->tete == NULL)
	{
		f->tete = f->queue->suivant;
	}
}

void extraire(File *f, char *v)
{
	assert(f != NULL);
	assert(! est_vide(*f));
	

	// TODO � faire...
}


int longueur(File f)
{
	// TODO � faire...
	return 0;
}

// vi: ts=4 sw=4:
