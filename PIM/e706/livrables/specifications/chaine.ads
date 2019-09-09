--Specification du module Chaine

package Chaine is

    
    type P_string is private;
    type t_bit is mod 2;
    
    --Initialiser une chaine de caracteres
    procedure Initialiser_chaine (chaine : out P_string) with
            Post => Vide_chaine(chaine);
			
    --Verifie si une chaine de caracteres est vide
    function Vide_chaine (chaine : in P_string) return Boolean ;
		
    --Ajouter un caractere dans la chaine de caractere
    procedure Ajout_caract ( chaine : in out P_string; caractere : in Character);
		
    --Supprimer le dernier caractere de la chaine
    procedure Supprimer_caract (chaine : in out P_string);
           
    --Supprimer le premier caractere de la chaine
    procedure Supprimer_prem_carac (chaine : in out P_string) with
            Pre => not Vide_chaine(chaine);
    
    --Retourne le premier caractere de la chaine
    function Get_prem_caract(chaine : in P_string) return Character with
            Pre => not Vide_chaine(chaine);
            
		
    --Supprimer toute la chaine de caracteres
    procedure Supprimer_chaine (chaine : in out P_string);
    
    --Retourner la nombre de caracteres enregistrés dans la chaine de caracteres
    function Taille_liste ( chaine : in P_string) return Integer with
            Post => 0 <= Taille_liste'Result ;
            
    --Fonction qui retourne le premier caractere d'une chaine non vide sous forme binaire
    --la chaine de caracteres ne doit comporter que des 0 et des 1
    function Recup_binaire(chaine : in P_string) return t_bit with
            Pre => not Vide_chaine(chaine);
			
    --Procedure qui affiche les caracteres d'un P_string
    procedure Afficher_chaine(chaine : in P_string) with
            Pre => not Vide_chaine(chaine);
    
    --Fonction qui renvoie une copie de la chaine
    function Copy (chaine : in P_string) return P_string;
    
    --Fonction qui renvoie si deux chaines de caracteres sont egales
    function Est_egal_string(string1 : in P_string; string2 : in P_string) return Boolean;


private
    
    
    type T_string;
    type P_string is access T_string;
    type T_string is record
        Caractere : Character;
        Suivant : P_string;
    end record;
		
		
end Chaine;
