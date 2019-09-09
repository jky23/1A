with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation; 

package body Chaine is


    procedure Free is new Ada.Unchecked_Deallocation ( T_string, P_string);

    procedure Initialiser_chaine (chaine : out P_string) is
    begin
        chaine := null;
    end Initialiser_chaine;
    
    function Vide_chaine (chaine : in P_string) return Boolean is 
    begin
        return (chaine = null);
    end Vide_chaine;
		
    procedure Ajout_caract ( chaine : in out P_string ;caractere : in Character) is
    begin 
        if Vide_chaine(chaine) then
            chaine := New T_string'(caractere,null);
        else
            Ajout_caract(chaine.all.Suivant,caractere);
        end if;
    end Ajout_caract;
		
    procedure Supprimer_caract (chaine : in out P_string) is
    begin
        if Vide_chaine(chaine.all.Suivant) then
            chaine := null;
        else 
            Supprimer_caract(chaine.all.Suivant);
        end if; 	
    end Supprimer_caract;
    
    procedure Supprimer_prem_carac (chaine : in out P_string) is 
    begin
        if not (Vide_chaine(chaine)) then
            chaine := chaine.all.Suivant;
        end if;
    end Supprimer_prem_carac;
    
    function Get_prem_caract(chaine : in P_string) return Character is
    begin
        return chaine.all.Caractere;
    end Get_prem_caract;
    
    
		
    procedure Supprimer_chaine (chaine : in out P_string) is
    begin
        if chaine /= null then
            Supprimer_chaine (chaine.all.Suivant);
            Free (chaine);
        else
            null;
        end if;
    end Supprimer_chaine;
    
    function Taille_liste ( chaine : in P_string) return Integer is
    begin
        if chaine = null then
            return 0;
        else
            return 1 + Taille_liste(chaine.all.Suivant);
        end if;
    end Taille_liste;
    
    function Recup_binaire(chaine : in  P_string) return t_bit is
        char : Character;
        binaire : t_bit;
    begin
        char := Get_prem_caract(chaine);
        if char = '0' then
            binaire := 0;		
        elsif char = '1' then
            binaire := 1;
        else
            null;
        end if;
        return binaire;
    end Recup_binaire;
    
    procedure Afficher_chaine(chaine : in P_string) is
    begin
        Put(Get_prem_caract(chaine));
        if not Vide_chaine(chaine.all.Suivant) then
            Afficher_chaine(chaine.all.Suivant);
        else
            null;
        end if;
    end Afficher_chaine;
    		
    function Copy (chaine : in P_string) return P_string is
    begin
        if chaine = null then
            return null;
        else
            return new T_string'(chaine.all.Caractere, Copy(chaine.all.Suivant));
        end if;
    end Copy;
    
   function Est_egal_string(string1 : in P_string; string2 : in P_string) return Boolean is
        char1, char2 : Character;
    begin
        if Taille_liste(string1) /= Taille_liste(string2) then
            return False;
        elsif Vide_chaine(string1) and Vide_chaine(string2) then
            return True;
        else
            char1 := Get_prem_caract(string1);
            char2 := Get_prem_caract(string2);
            if char1 /= char2 then
                return False;
            else
                return Est_egal_string(string1.all.Suivant, string2.all.Suivant);
            end if;
        end if;
    end Est_egal_string;
    
            
            
            
        

    end Chaine;
