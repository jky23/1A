with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Command_line; use Ada.Command_line;
with Chaine; use Chaine;
with Arbre; use Arbre;
with Ada.Finalization; use Ada.Finalization;

package body Table_Code is

    procedure Initialiser_Table (Table: out P_Code) is
    begin
        Table := Null;
    end Initialiser_Table;

    function Taille (Table : in P_Code) return Integer is
    begin
        if Table = Null then
            return 0;
        else
            return Taille(Table.all.Suivant) + 1;
        end if;
    end Taille;

    procedure Ajouter_Element (Table : in out P_Code ; Caractere : in Character ; Code : in P_string) is
    begin
        if Table = Null then
           Table := New T_Code'(Caractere, Code, null);
        else
            Ajouter_Element (Table.all.Suivant , Caractere , Code);
        end if;
    end Ajouter_Element;

    function Est_Present_Code (Table : in P_Code ; Code : in P_string) return Boolean is
    begin
        if Table = Null then
            return False;
        elsif Est_egal_string(Table.all.Code, Code) then
            return True;
        else
            return Est_Present_Code (Table.all.Suivant , Code);
        end if;
    end Est_Present_Code;

    function Caractere_Par_Code (Table : in P_Code ; Code : in P_string) return Character is
    begin
        if Est_egal_string(Table.all.Code,Code) then
            return Table.all.Caractere;
        else
            return Caractere_Par_Code (Table.all.Suivant , Code);
        end if;
    end Caractere_Par_Code;

    function Code_Par_Caractere (Table : in P_Code ; Caractere : in Character) return P_string is
    begin
        if Table.all.Caractere = Caractere then
            return Table.all.Code;
        else
            return Code_Par_Caractere (Table.all.Suivant , Caractere);
        end if;
    end Code_Par_Caractere;

    procedure Afficher (Table : in P_Code) is
    begin
        if Table = Null then
            Null;			
        else
            Put("'");
            Put(Table.all.Caractere);
            Put("' -> " );
            Afficher_chaine(Table.all.Code);
            New_Line;
            Afficher(Table.all.Suivant);
        end if;
    end Afficher;

    procedure Creer_Table (Table : in out P_Code ; Arbre : in P_arb ; Code : in out P_string) is
    begin
        if Arbre_vide(Get_gauche(Arbre)) then
            Ajouter_Element (Table,Get_caractere(Arbre),Copy(Code));
        else
            Ajout_caract (Code,'0');
            Creer_Table (Table,Get_gauche(Arbre),Code);
            Supprimer_caract(Code);
            Ajout_caract (Code,'1');
            Creer_Table (Table,Get_droit(Arbre),Code);
            Supprimer_caract(Code);
        end if;
    end Creer_Table;
    
 
        
    
end Table_Code;
