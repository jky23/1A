/*******************************************************************************
 *  Auteur   : Xavier Crégut <cregut@enseeiht.fr>
 *  Version  : $Revision$
 *  Objectif : Définition simplifiée d'un monnaie
 ******************************************************************************/

#include <stdlib.h>
#define CONST 5

//// Question 1 : Définition du type Monnaie /////////////////////////////////
struct Monnaie 
{ 
	double valeur;
	char devise;
};

typedef struct Monnaie Monnaie;


//// Question 2 : Initialiser ////////////////////////////////////////////////
void initialiser (double valeur, char devise, Monnaie *monnaie)
{
	assert (valeur >0);
	monnaie -> valeur = valeur;
	monnaie -> devise = devise; 
}

//// Question 3 : Ajouter ////////////////////////////////////////////////////
void ajouter (Monnaie *m1 , Monnaie m2) // m2 est la monnaie à ajouter a  m1 
{
	assert (m1 -> valeur>0);
	assert (m2 -> valeur>0);
	assert (m1 -> devise == m2.devise);
	m1 -> valeur = m1 -> valeur + m2.valeur;
	
	return EXIT_SUCCESS;
}


//// Question 4 : Tester /////////////////////////////////////////////////////
void tester_monnaie ()
{
	initialiser (12,e,m1);
	initialiser (45.5,c,m2);
	initialiser (54,$,m3);
	assert (m1.valeur = 12);
	assert (m3.valeur = 45);
	assert (m2.devise =  c);
	ajouter (&m1,m2);
	initialiser (85,e,m4);
	ajouter (&m1,m4);
	assert (m1.valeur = 97);
}



//// Question 5 : Programme principal ////////////////////////////////////////




int main()
{
	typedef Monnaie porte_monnaie [CONST]; //initialiser le tableau de 5 monnaies
	for (int i =0; i< CONST; i++)  //initialise chaque element du tableau en demandant la valeur et la devise d'une monnaie
	{
		double val;
		char dev;
		Monnaie m;
		printf("Entrer la valeur positive et la devise de la monnaie");
		printf("valeur, devise =");
		scanf("%d, %c",&val &dev);
		initialiser(val,dev,&m);
		porte_monnaie[i] = m;
	}
	char dev;
	printf("Entrer la devise pour la somme des monnaies"); //calcule la somme des monnnaies
	scanf("%c",&dev);
	Monnaie m1;
	do {
		int i = 0;
		if (porte_monnaie[i]->devise = dev) {
			ajouter(&m1,porte_monnaie[i]);
		}
		i++;
	} while (i = CONST);
	printf("La somme des monnaies est: %d %c \n", m1 ->valeur ,m1 ->devise); //affiche la somme des monnaies
	
	
	
    return EXIT_SUCCESS;
}
