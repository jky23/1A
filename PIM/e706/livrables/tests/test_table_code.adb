with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Chaine; use Chaine;
with Table_Code; use Table_Code;

procedure test_table_code (Table : out P_Code) is

	procedure Tester_Initialiser (Table : out P_Code) is
	begin
		Initialiser_Table (Table);
		pragma assert( Taille (Table) = 0);
	end Tester_Initialiser;

	procedure Tester_Ajouter is
		Table : P_Code;
	begin
		Tester_Initialiser (Table);
		pragma assert( Est_Present_Code  (Table,11) = False);
		Ajouter_Element (Table,'a',11);
		pragma assert( Est_Present_Code (Table,11) = True);
		Ajouter_Element (Table,'b',1001);
		pragma assert( Est_Present_Code (Table,1001) = True);
		pragma assert( Taille (Table) = 2);
		Afficher (Table);
	end Tester_Ajouter;

	procedure Tester_Infos_Element is
		Table : P_Code;
	begin
		Tester_Intialiser (Table);
		Ajouter_Element (Table,'c',101);
		pragma assert( Caractere_Par_Code (Table,101) = 'c');	
		pragma assert( Code_Par_Caractere (Table,'c') = 101);
		Ajouter_Element (Table,'d',1000);
		pragma assert( Caractere_Par_Code (Table,1000) = 'd');	
		pragma assert( Code_Par_Caractere (Table,'d') = 1000);
		Afficher (Table);
        end Tester_Infos_Element;

begin
	Tester_Ajouter;
	Tester_Infos_Element;
end test_table_code;
