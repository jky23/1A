with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;

package body Tab_Freq is

	procedure Initialiser_Tab (Tableau : out P_Tab_Freq) is
	begin
		Tableau := Null;
	end Initialiser_Tab;

	function Taille (Tableau : P_Tab_Freq) return Integer is
	begin
		if Tableau = Null then
			return 0;
		else
			return Taille (Tableau.all.Suivant) + 1;
		end if;
	end Taille;

	procedure Ajouter_Caractere (Tableau : in out P_Tab_Freq ; Caractere : in Character) is
	begin
		if Tableau = Null then
			Tableau := new T_Tab_Freq'(Caractere , 1 , Null);
		elsif Tableau.all.Caractere = Caractere then
			Tableau.all.Frequence := Tableau.all.Frequence + 1;
		else 
			Ajouter_Caractere (Tableau.all.Suivant , Caractere);
		end if;
	end Ajouter_Caractere;

	function Ieme_Caractere (Tableau : P_Tab_Freq ; Indice : Integer) return Character is
	begin
		if Indice = 1 then
			return Tableau.all.Caractere;
		else
			return Ieme_Caractere (Tableau.all.Suivant , Indice - 1);
		end if;
	end Ieme_Caractere;

	function Frequence_Du_Caractere (Tableau : in P_Tab_Freq ; Caractere : in Character) return Integer is
	begin
		if Tableau.all.Caractere = Caractere then
			return Tableau.all.Frequence;
		else
			return Frequence_Du_Caractere (Tableau.all.Suivant , Caractere);
		end if;
	end Frequence_Du_Caractere;

end Tab_Freq;
