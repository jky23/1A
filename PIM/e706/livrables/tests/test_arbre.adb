with Arbre; use Arbre;
with Chaine; use Chaine;
with Ada.Text_IO; use Ada.Text_IO;

--Programme de test du module Arbre
procedure test_arbre is
    
    procedure Test_initialiser is
        arb1,arb2 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
   
    end Test_initialiser;
    
    procedure Test_creer_noeud is
        arb1,arb2 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
    end Test_creer_noeud;
    
    procedure Test_get_caractere is
        arb1,arb2 : P_arb;
        x,y : Character;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        x := Get_caractere(arb1);
        pragma Assert (x = 'e');
        y := Get_caractere (arb2);
        pragma Assert (y = 'a');
    end Test_get_caractere;
    
    procedure Test_get_frequence is
        arb1,arb2 : P_arb;
        a,b : Integer;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        a := Get_frequence (arb1);
        b := Get_frequence (arb2);
        pragma Assert (a = 5);
        pragma Assert (b = 3);
    end Test_get_frequence;
    
    procedure Test_get_gauche is
        arb1,arb2,arb3,arb4 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        arb4 := Get_gauche(arb3);
        pragma Assert (arb4 = arb1);
        
    end Test_get_gauche;
    
    procedure Test_get_droit is
        arb1,arb2,arb3,arb4 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        arb4 := Get_droit(arb3);
        pragma Assert (arb4 = arb2);
    end Test_get_droit;
    
    procedure Test_sommer is
        arb1, arb2, arb3 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        pragma Assert (Get_frequence(arb3) = 10);
        pragma Assert (Get_gauche(arb3) = arb1);
        pragma Assert (Get_droit(arb3) = arb2);
    end Test_sommer;
        
    procedure Test_remplacer_frequence is
        arb1,arb2 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        Remplacer_frequence (arb1,7);
        pragma Assert (Get_frequence(arb1) = 7);
    end Test_remplacer_frequence;
    
    procedure Test_remplacer_caractere is
        arb1,arb2 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        Remplacer_caractere (arb2,'z');
        pragma Assert (Get_caractere(arb2) = 'z');
    end Test_remplacer_caractere;
    
    procedure Test_afficher is
        arb1, arb2, arb3 : P_arb;
    begin
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        Afficher_arbre(arb3);
    end Test_afficher;
    
    procedure Test_description is
        n : Integer;
        arb1, arb2, arb3 : P_arb;
        code : P_string;
    begin
        n := 2;
        Initialiser_arbre(arb3);
        Initialiser_chaine(code);
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        Descrip_arbre(arb3,code,n);
    end Test_description;
    
    procedure Test_get_list_caract is
        arb1, arb2, arb3 : P_arb;
        chaine : P_string;
    begin
        Initialiser_arbre(arb3);
        Initialiser_chaine(chaine);
        Initialiser_arbre(arb1);
        Initialiser_arbre(arb2);
        arb1 := Creer_noeud (5,'e');
        arb2 := Creer_noeud(3,'a');
        arb3 := Sommer_arbre(arb1,arb2);
        Get_list_caract(arb3,chaine);
    end Test_get_list_caract;
    
    procedure Test_recons_arb is
    begin
        null;
    end Test_recons_arb;
    
   

begin
    Test_initialiser;
    Test_creer_noeud;
    Test_get_caractere;
    Test_get_frequence;
    Test_get_gauche;
    Test_get_droit;
    Test_sommer;
    Test_remplacer_frequence;
    Test_remplacer_caractere;
    Test_afficher;	
    Test_description;
    Test_get_list_caract;
    Test_recons_arb;
	
	
    


end test_arbre;
