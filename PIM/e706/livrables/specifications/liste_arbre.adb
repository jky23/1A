with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Arbre; use Arbre;

package body Liste_arbre is
    
    procedure Free is new Ada.Unchecked_Deallocation ( List_arb, T_list_arb);

    procedure Initialiser_list_arb ( liste : out T_list_arb) is
    begin
        liste := null;
    end Initialiser_list_arb;
		 
	     
    function Est_nul_liste ( liste : in T_list_arb) return Boolean is
    begin
        return(liste = null);
    end Est_nul_liste;
    
    function Get_prem_arb(liste : in T_list_arb) return P_arb is
    begin
        return liste.all.Arbre;
    end Get_prem_arb;
    
       
    
	     
    procedure Detruire_prem_arb(liste : in out T_list_arb ) is
    begin
        liste := liste.all.suivant;
    end Detruire_prem_arb;
	     
    procedure Detruire_list_arb (liste : in out T_list_arb) is
    begin
        if liste /= null then
            Detruire_list_arb ( liste.all.suivant);
            Free (liste);
        else
            null;
        end if;
        
    end Detruire_list_arb;
	     
    procedure Placer_croissant( liste : in out T_list_arb ; arbre : in P_arb) is
        list_suiv : T_list_arb;
        New_list : T_list_arb;
    begin
        if Est_nul_liste(liste) then
            liste := New List_arb'(arbre, null);
            -- elsif (Get_frequence(liste.all.Arbre) <= Get_frequence(arbre) then
        elsif (Get_frequence(liste.all.Arbre) >= Get_frequence(arbre)) then
            -- list_suiv := liste.all.Suivant;
            list_suiv := liste;
            New_list := New List_arb'(arbre, list_suiv);
            liste := New_list;
        else
            Placer_croissant (liste.all.Suivant,arbre);
        end if;
    end Placer_croissant;
    
    function Get_arb (liste : in T_list_arb) return P_arb is
    begin 
            return liste.all.Arbre;       
    end Get_arb;
    
    function Taille_liste (liste : in T_list_arb) return Integer is
    begin
        if liste = null then
            return 0;
        else
            return 1 + Taille_liste(liste.all.Suivant);
        end if;               
    end Taille_liste;
    
    function Somme_premier(liste : in T_list_arb) return P_arb is 
    begin
        return Sommer_arbre(liste.all.Arbre,liste.all.Suivant.all.Arbre);
    
    end Somme_premier;
    
  
end Liste_arbre;
			

