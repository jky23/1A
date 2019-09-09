/**
 * \file pgcd.c
 * \brief Calculer le pgcd de deux nombres entiers strictement positifs.
 * \author Xavier Crégut <nom@n7.fr>
 * \version 1.0
 */

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <stdbool.h>

/**
 * \brief le pgcd de deux entiers strictrement positifs \a a et \a b.
 * \param[in] a le premier entier (> 0)
 * \param[in] b le deuxième entier (> 0)
 * \return le pgcd de a et b
 * \pre a strictement positif : a > 0
 * \pre b strictement positif : b > 0
 * \post le résultat est le plus grand diviseur commun à a et b :
 *	a % result == 0
 *	&& b % result == 0
 *	&& "c'est le plus grand !"
 */
int pgcd(int a, int b) 
{
    assert(a > 0);
    assert(b > 0);

    while (a != b) {
	if (a > b) {
	    a = a - b;
	}
	else {
	    b = b - a;
	}
    }
    return a;
}

/**
 * \brief Programme de test de la fonction pgcd.
 */
void tester_pgcd()
{
    assert(4 == pgcd(4, 4));      // A = B
    assert(2 == pgcd(10, 16));    // A < B
    assert(1 == pgcd(21, 10));    // A > B
    assert(21 == pgcd(105, 147));  // un autre
}

/**
 * \brief Programme de test de la fonction pgcd.
 */
void tester_pgcd_limite()
{
    assert(1 == pgcd(1, 1000000000));	// long ?
}

/**
 * \brief Vérifier qu'une \a valeur entière est strictement postive.
 * \details
 *    Un message est affiché si la condition n'est pas vérifiée et
 *    \â resultat est mis à faux.
 * \a resultat est mis à faux si cette condition n'est pas satisfaite.
 * \param[in] nom le nom de l'entier
 * \param[in] valeur la valeur de l'entier
 * \param[in, out] resultat mis à faux si \a valeur n'est pas strictement positive
 * \pre resultat défini : resultat != NULL;
 * \post affiche un message et met \a resulat à faux si valeur négative :
 *	valeur <= 0 ==> ! *resulat
 */
void verifier_strictement_positif(char nom, int valeur, bool *resultat)
{
    assert(resultat != NULL);

    if (valeur <= 0) {
	printf("La valeur de %c, %i, devrait être strictement positive\n",
		nom, valeur);
	*resultat = false;
    }
}

/**
 * \brief Afficher le pgcd de deux entiers strictement positifs.
 * \details
 *     Les deux entiers sont saisis au clavier.
 *     Le pgcd est affiché dans le terminal.
 * \return EXIT_SUCCESS (pas d'erreur)
 */
int main()
{
    tester_pgcd();
    tester_pgcd_limite();

    /* saisir les valeurs de a et b	*/
    /* Attention, aucun contrôle n'est fait que les entiers saisis ! */
    int a, b;
    bool saisie_ok;
    do {
	// Saisir deux entiers		a, b : out
	printf("Donnez deux valeurs entières strictement positives.\n");
	printf("A, B = ");
	int n = scanf("%i , %i", &a, &b);

	// Contrôler la saisie		n, a, b: in; saisie_ok: out
	if (n != 2) {
	    saisie_ok = false;
	    printf("Il faut donner deux entiers !\n");
	    // supprimer les caractères de l'entrée standard.
	    int c = getchar();
	    while (c != '\n' && c != EOF) {
		c = getchar();
	    }
	} else {
	    saisie_ok = true;
	    verifier_strictement_positif('A', a, &saisie_ok);
	    verifier_strictement_positif('B', b, &saisie_ok);
	}
    } while (! saisie_ok);

    /* calculer le pgcd (algorithme d'Euclide)	*/
    int le_pgcd = pgcd(a, b);

    /* afficher le résultat	*/
    printf("pgcd(%i, %i) = %i\n", a, b, le_pgcd);

    return EXIT_SUCCESS;
}
// 1.1-les parametres de la fonction main ne seront pas modifiés car elle sont passés a la fonction par valeur
// 1.2-Le pointeur permet de pouvoir modifier le booleen passer en paramètre qui est en mode de sortie out et donc on effectue un passage par adresse. l'assertion en debut de programme verifie que le pointeur resultat soit different de nul parce que passé par adresse.
//  le parametre resultat est en in out parce que le programme lit et modifie sa valeur
// 1.3-le format "%i ,%i" du scanf permet de lire un entier. L'entier retourné par le scanf correspond au nombre d'entiers lus par le scanf
