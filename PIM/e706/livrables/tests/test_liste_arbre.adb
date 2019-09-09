with Ada.Text_IO; use Ada.Text_IO;
with Arbre; use Arbre;
with Liste_arbre; use Liste_arbre;

--Specification du module Arbre
procedure Test_liste_arbre is

    procedure Test_Initialiser is
        liste : T_list_arb;
    begin
        Initialiser_list_arb (liste);
    end Test_Initialiser;
    
    procedure Test_nul_liste is
        liste : T_list_arb;
        T : Boolean;
    begin
        Initialiser_list_arb (liste);
        T := Est_nul_liste(liste);
        pragma Assert(T=True);
    end Test_nul_liste;
    
    procedure Test_get_prem_arb is
        N1,N2 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'p');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        N2 := Get_prem_arb(liste);
        pragma Assert(N2 = N1);
    end Test_get_prem_arb;
    
    procedure Test_detruire_prem is
        N1,N2 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (7,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
        Detruire_prem_arb(liste);
        Detruire_prem_arb(liste);
    end Test_detruire_prem;
    
    procedure Test_detruire_list is
        N1,N2 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (7,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
        Detruire_list_arb(liste);
    end Test_detruire_list;
    
    
    procedure Test_placer is
        N1,N2 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (2,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
    end Test_placer;
    
    procedure Test_get_arb is
        N1,N2,N3,N4 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (7,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
        N3 := Somme_premier(liste);
        N3 := Somme_premier(liste);
        Placer_croissant(liste,N3);
        Detruire_prem_arb(liste);
        detruire_prem_arb(liste);
        N4 := Get_arb(liste);
        pragma Assert(N4 = N3);
    end Test_get_arb;
    
    procedure Test_taille is
        N1,N2,N3 : P_arb;
        liste : T_list_arb;
        n : Integer;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (7,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
        N3 := Somme_premier(liste);
        n := Taille_liste(liste);
        pragma Assert (n=2);
    end Test_taille;
    
    procedure Test_sommer is
        N1,N2,N3 : P_arb;
        liste : T_list_arb;
    begin
        Initialiser_arbre (N1);
        N1 := Creer_noeud (5,'c');
        Initialiser_arbre (N2);
        N2 := Creer_noeud (7,'j');
        Initialiser_list_arb (liste);
        Placer_croissant (liste,N1);
        Placer_croissant(liste,N2);
        N3 := Somme_premier(liste);
        pragma Assert(Get_frequence(N3) = 12);
    end Test_sommer;
    
    
begin
    Test_Initialiser;
    Test_nul_liste;
    Test_get_prem_arb;
    Test_detruire_prem;
    Test_detruire_list;
    Test_placer;
    Test_get_arb;
    Test_taille;
    Test_sommer;
	
    
end Test_liste_arbre;
