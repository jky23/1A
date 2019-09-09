with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Chaine; use Chaine;

package body Arbre is 
    
    procedure Free is new Ada.Unchecked_Deallocation ( T_arb ,P_arb);

    procedure Initialiser_arbre ( arbre : out P_arb) is
    begin
        arbre := null;
    end Initialiser_arbre;
			
    function Arbre_vide (arbre : in P_arb) return Boolean is
    begin
        return (arbre=null);
    end arbre_vide;

			
    function Creer_noeud (frequence : in Integer ; caractere : in Character) return P_arb is
        N : P_arb;
    begin
        Initialiser_arbre (N);
        N := new T_arb'(frequence,caractere,null,null);
        return N;
    end Creer_noeud;
    
    function Get_caractere ( arbre : in P_arb) return Character is
    begin
        return arbre.all.Caractere;
    end Get_caractere;
    
    function Get_frequence (arbre : in P_arb) return Integer is
    begin
        return arbre.all.Frequence;
    end Get_frequence;
	
    function Get_gauche (arbre : in P_arb) return P_arb is
    begin
        return arbre.all.Sous_arbre_gauche;
    end Get_gauche;
	
    function Get_droit (arbre : in P_arb) return P_arb is
    begin
	return arbre.all.Sous_arbre_droit;
    end Get_droit;
			
    function Sommer_arbre ( arbre1 : in P_arb ; arbre2 : in P_arb) return P_arb is
        arbre : P_arb;
    begin
        Initialiser_arbre(arbre);
        arbre := New T_arb'(arbre1.all.Frequence + arbre2.all.Frequence,'#',arbre1,arbre2);
        return arbre;
    end Sommer_arbre;
			
    procedure Remplacer_frequence (arbre : in P_arb ; frequence : Integer) is
    begin
        arbre.all.Frequence := frequence;
    end Remplacer_frequence;
			
    procedure Remplacer_caractere (arbre : in P_arb ; caractere : Character) is
    begin
        arbre.all.Caractere := caractere;
    end Remplacer_caractere;
    
    procedure Afficher_arbre(arbre : in P_arb; compteur : in out Integer) is
    begin
        Put("(");
        Put(Integer'Image(Get_frequence(arbre)));
        Put(")");
        if Get_gauche(arbre) = null and Get_droit(arbre) = null then
            Put("  ");
            Put("'");
            Put(arbre.all.Caractere);
            Put("'");
            New_Line;
            
        else
            New_Line;
            if compteur /= 0 then
                for i in 1..compteur loop
                Put("        ");
                end loop;
            end if;
            Put("\--0--");
            compteur := compteur + 1;
            Afficher_arbre(arbre.all.Sous_arbre_gauche,compteur);
            compteur := compteur -1;
            New_Line;
            if compteur /= 0 then
                for i in 1..compteur loop
                Put("        ");
                end loop;
            end if;
            Put("\--1--");
            compteur := compteur +1;
            Afficher_arbre(arbre.all.Sous_arbre_droit,compteur);
            compteur := compteur - 1;
        end if;
       
    end Afficher_arbre;
	     
	     
    procedure Descrip_arbre ( arbre : in P_arb ; Code : in out P_string ; Elements_manquant : in out Integer) is
    begin
        if arbre.all.Sous_arbre_gauche = null then
            Ajout_caract (Code,'1');
            Elements_manquant := Elements_manquant - 1;
	else
		Ajout_caract (Code, '0');
		Descrip_arbre (arbre.all.Sous_arbre_gauche , Code, Elements_manquant);
		Ajout_caract (Code, '0');
		Descrip_arbre (arbre.all.Sous_arbre_droit , Code, Elements_manquant);
                if Elements_manquant = 0 then
                     null;
                Else
                     Ajout_caract (Code, '1');
                end if;
	end if;
    end Descrip_arbre;
	     
    procedure Get_list_caract ( arbre : in P_arb; L : in out P_string) is
    begin
        if Get_gauche(arbre) = null and Get_droit(arbre) = null then
            Ajout_caract (L,Get_caractere(arbre));
        else
            Get_list_caract (arbre.all.Sous_arbre_gauche,L);
            Get_list_caract (arbre.all.Sous_arbre_droit,L);
        end if;         
    end Get_list_caract;
	     
    procedure Recons_arb (code : in out P_string; liste : in out P_string; arb : in out P_arb) is
    begin
    	if Vide_chaine(code) then
		null;
	else
    		if Get_prem_caract (code) = '0' then
			if arb.all.Sous_arbre_gauche = null then
				arb.all.Sous_arbre_gauche := New T_arb' (0,'#',null,null);
				arb.all.Sous_arbre_droit := New T_arb' (0,'#',null,null);
				Supprimer_prem_carac(code);
				Recons_arb(code , liste , arb.all.Sous_arbre_gauche);
				Supprimer_prem_carac(code);
                                Recons_arb(code , liste , arb.all.Sous_arbre_droit);
                                Supprimer_prem_carac(code);
			end if;
		else
			if arb.all.Sous_arbre_gauche = null then
				arb.all.Caractere := Get_prem_caract(liste);
				Supprimer_prem_carac(liste);
			else
				null;
			end if;
			Supprimer_prem_carac(code);
		end if;
	end if;        
    end Recons_arb;
	     
        
end Arbre;
