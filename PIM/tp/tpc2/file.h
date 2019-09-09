/**
 *  \author Xavier Crégut <nom@n7.fr>
 *  \file
 *
 *  Spécification d'une file chaînée.
 */

#include <stdbool.h>

#ifndef FILE__H
#define FILE__H

/** Une cellule de la file chaînée. */
typedef struct Cellule Cellule;	/* éviter de répéter le struct */
	// Remarque : ceci revient à :
	// 1. déclarer le type struct Cellule. C'est l'équivalent de faire :
	//		struct Cellule;
	// 2. définir un alias sur ce type (typedef).

/** Une cellule de la file. */
struct Cellule {
	char valeur;		/**< La valeur de la cellule. */
	Cellule *suivante;	/**< Un pointeur sur la cellule suivante (ou NULL). */
};

/** Une file chaînée avec un accès sur la première, \a tete, et la dernière
 * cellule, \a queue.
 *
 *  \invariant Pour toute file \a f,
 *         est_vide(f) <==> f.tete == NULL && f.queue == NULL
 */
struct File {
	Cellule *tete;	/**< La première cellule de la file (ou NULL). */
	Cellule *queue;	/**< La dernière cellule de la file (ou NULL). */
};

/** Une file chaînée. */
typedef struct File File;


/**
 * Initialiser la file \a f.
 * La file est vide.
 *
 * \post est_vide(*f);
 */
void initialiser(File *f);

/**
 * Détruire la file \a f.
 * Cette file ne pourra plus être utilisée sauf à être initialisée à nouveau.
 */
void detruire(File *f);

/**
 * L'élément en tête de la file.
 */
char tete(File f);

/**
 * Ajouter dans la file \a f l'élément \a v.
 *
 * \pre f != NULL;
 */
void inserer(File *f, char v);

/**
 * Extraire l'élément \a v en tête de la file \a f.
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
