/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file
 *
 *  Sp�cification d'une file cha�n�e.
 */

#include <stdbool.h>

#ifndef FILE__H
#define FILE__H

/** Une cellule de la file cha�n�e. */
typedef struct Cellule Cellule;	/* �viter de r�p�ter le struct */
	// Remarque : ceci revient � :
	// 1. d�clarer le type struct Cellule. C'est l'�quivalent de faire :
	//		struct Cellule;
	// 2. d�finir un alias sur ce type (typedef).

/** Une cellule de la file. */
struct Cellule {
	char valeur;		/**< La valeur de la cellule. */
	Cellule *suivante;	/**< Un pointeur sur la cellule suivante (ou NULL). */
};

/** Une file cha�n�e avec un acc�s sur la premi�re, \a tete, et la derni�re
 * cellule, \a queue.
 *
 *  \invariant Pour toute file \a f,
 *         est_vide(f) <==> f.tete == NULL && f.queue == NULL
 */
struct File {
	Cellule *tete;	/**< La premi�re cellule de la file (ou NULL). */
	Cellule *queue;	/**< La derni�re cellule de la file (ou NULL). */
};

/** Une file cha�n�e. */
typedef struct File File;


/**
 * Initialiser la file \a f.
 * La file est vide.
 *
 * \post est_vide(*f);
 */
void initialiser(File *f);

/**
 * D�truire la file \a f.
 * Cette file ne pourra plus �tre utilis�e sauf � �tre initialis�e � nouveau.
 */
void detruire(File *f);

/**
 * L'�l�ment en t�te de la file.
 */
char tete(File f);

/**
 * Ajouter dans la file \a f l'�l�ment \a v.
 *
 * \pre f != NULL;
 */
void inserer(File *f, char v);

/**
 * Extraire l'�l�ment \a v en t�te de la file \a f.
 *
 * \pre f != NULL;
 * \pre ! est_vide(*f);
 */
void extraire(File *f, char *v);

/**
 * Est-ce que la file \a f  est vide ?
 */
bool est_vide(File f);

/**
 * Obtenir la longueur de la file.
 */
int longueur(File f);

#endif
// vi: ts=4 sw=4:
