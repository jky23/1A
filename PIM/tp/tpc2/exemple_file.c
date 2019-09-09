#include "file.h"
#include <stdio.h>
#include <stdlib.h>

/**
 * \brief Afficher la file.
 * \details Le nom de la file est affiché suivi d'un signe '=' et
 * du contenu de la file.
 * Comme nous n'avons pas accès à des opérations de parcours de la file,
 * on extrait ses éléments pour les afficher et on les ajoute de nouveau.
 * C'est pour cette raison que la file \a f est en in out.
 *
 * \param[in]     nom_file le nom à afficher avant le contenu de la file
 * \param[in,out] f la file à afficher
 */
void afficher_une_file(const char nom_file[], File *f) {
	printf("%s = ", nom_file);

	// afficher la file.
	// Principe : extraire chaque élément pour l'afficher (et l'insérer).
	int taille = longueur(*f);
	for (int i = 0; i < taille; i++) {
		char element;
		extraire(f, &element);
		printf("-->[ '%c' ]", element);
		inserer(f, element);
	}
	printf("--E");
	putchar('\n');
}

/**
 * \brief Exemple d'utilisation de la file.
 */
int main()
{
	File f1;
	char valeur;

	initialiser(&f1);
	afficher_une_file("f1", &f1);

	inserer(&f1, 'X');
	printf("\ninsertion de : %c\n", 'X');
	afficher_une_file("f1", &f1);

	inserer(&f1, 'Y');
	printf("\ninsertion de : '%c'\n", 'Y');
	afficher_une_file("f1", &f1);

	extraire(&f1, &valeur);
	printf("\nextraction de : '%c'\n", valeur);
	afficher_une_file("f1", &f1);

	extraire(&f1, &valeur);
	printf("\nextraction de : '%c'\n", valeur);
	afficher_une_file("f1", &f1);

	detruire(&f1);

	return EXIT_SUCCESS;
}

// vi: ts=4 sw=4:
