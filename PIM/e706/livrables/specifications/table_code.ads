with Chaine; use Chaine;
with Arbre; use Arbre;

package Table_Code is

	Type P_Code is private;

	-- Initialise la table de codage
	procedure Initialiser_Table (Table : out P_Code) with
		post => Taille(Table) = 0;

	-- Permet de connaître la taille de la table de codage, càd le nombre d'élément qui la compose
	function Taille (Table : in P_Code) return Integer;

	-- Ajouter un element à la table de codage
	procedure Ajouter_Element (Table : in out P_Code ; Caractere : in Character ; Code : in P_string) with
		post => Taille(Table)'Old = Taille(Table) - 1;

	-- Renvoie un bouléen indiquant l'éventuelle présence d'un code dans la table de codage
	-- (A utiliser avec Caractere_Par_Code afin d'eviter d'y rentrer en parametre un code qui n'y est pas)
	function Est_Present_Code (Table : in P_Code ; Code : in P_string) return Boolean;

	-- Permet de connaître le caractère associé à un code dans la table de codage
	function Caractere_Par_Code (Table : in P_Code ; Code : in P_string) return Character;

	-- Permet de connaîte le code associé à un caractère dans la table de codage
	-- (Il est inutile de tester l'éventuelle présence du caractère en "in" puisque celui-ci provient du texte dont est extraite la table de codage)
	function Code_Par_Caractere (Table : in P_Code ; Caractere : in Character) return P_string;

	-- Affiche la table de codage
	procedure Afficher (Table : in P_Code);

	-- Créer la table de code en entier en le parcourant une seule fois
	-- le paramètre Code servira à garder en mémoire le Code pendant l'utilisation récursive de la procédure
	procedure Creer_Table (Table : in out P_Code; Arbre : in P_arb ; Code : in out P_string);

private

        Type T_Code;

        Type P_Code is access T_Code;

	Type T_Code is record
		Caractere : Character;
		Code : P_string;
		Suivant : P_Code;
	end record;

end Table_Code;
