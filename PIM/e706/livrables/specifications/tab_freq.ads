package Tab_Freq is

	Type P_Tab_Freq is private;

	-- Initialise le tableau de fréquence
	procedure Initialiser_Tab (Tableau : out P_Tab_Freq) with
		post => Taille(Tableau) = 0;

	-- Permet de connaître la taille du tableau de fréquence
	function Taille (Tableau : in P_Tab_Freq) return Integer;

	-- Ajouter un caractère dans le tableau de fréquence
	-- Si le caractère est déjà présent dans le tableau => incrémenter sa valeur de 1
	-- Sinon => Ajouter une case dans le tableau contenant le caractère en question et la valeur 1
	procedure Ajouter_Caractere (Tableau : in out P_Tab_Freq ; Caractere : in Character) with
		post => Taille(Tableau)'Old <= Taille(Tableau);

	-- Renvoie le caractère de la case se trouvant à un indice donné du tableau
	-- (la notion d'indice n'est pas réellement définie, il s'agit juste du i-ème élément du tableau)
	function Ieme_Caractere (Tableau : in P_Tab_Freq ; Indice : in Integer) return Character with
		pre => Indice <= Taille(Tableau);

	-- Renvoie la fréquence associée à un caractère du tableau
	-- (cette fonction est à utiliser avec la fonction Ieme_Caractere afin d'obtenir l'intégralité des éléments d'une case du tableau)
	function Frequence_Du_Caractere (Tableau : in P_Tab_Freq ; Caractere : in Character) return Integer;

private

	Type T_Tab_Freq;

	Type P_Tab_Freq is access T_Tab_Freq;

	Type T_Tab_Freq is record
		Caractere : Character;
		Frequence : Integer;
		Suivant : P_Tab_Freq;
	end record;

end Tab_Freq;
