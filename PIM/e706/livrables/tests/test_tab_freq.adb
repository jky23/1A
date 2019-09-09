with Tab_Freq; use Tab_Freq;
with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;

procedure test_tab_freq is

	procedure Tester_Initialiser (Tableau : out P_Tab_Freq) is
	begin
		Initialiser_Tab (Tableau);
		pragma Assert ( Taille(Tableau) = 0);
		Ajouter_Caractere (Tableau,'a');
		Ajouter_Caractere (Tableau,'a');
		Ajouter_Caractere (Tableau,'b');
	end Tester_Initialiser;

	procedure Tester_Ajouter is
		Tableau : P_Tab_Freq;
	begin		
		Initialiser_Tab (Tableau);
		Ajouter_Caractere (Tableau,'a');
		pragma Assert ( Taille(Tableau) = 1);
		Ajouter_Caractere (Tableau,'a');
		Ajouter_Caractere (Tableau,'a');
		pragma Assert ( Taille(Tableau) = 1);
		Ajouter_Caractere (Tableau,'b');
		pragma Assert ( Taille(Tableau) = 2);
	end Tester_Ajouter;

	procedure Tester_Infos_Element is
		Tableau : P_Tab_Freq;
	begin
		Tester_Initialiser(Tableau);
		pragma assert( Ieme_Caractere (Tableau,1) = 'a');
		pragma assert( Frequence_Du_Caractere (Tableau,'a') = 2);
		pragma assert( Ieme_Caractere (Tableau,2) = 'b');
		Ajouter_Caractere (Tableau,'c');
		pragma assert( Ieme_Caractere (Tableau,3) = 'c');
		pragma assert( Frequence_Du_Caractere (Tableau,'c') = 1);
		Ajouter_Caractere (Tableau,'c');
		pragma assert( Frequence_Du_Caractere (Tableau,'c') = 2);
		Ajouter_Caractere (Tableau,'a');
		pragma assert( Frequence_Du_Caractere (Tableau,'a') = 3);
	end Tester_Infos_Element;

begin
	Tester_Ajouter;
	Tester_Infos_Element;
end test_tab_freq;
