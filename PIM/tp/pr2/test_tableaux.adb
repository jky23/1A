--KY Joël Roman
--Groupe M

with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Integer_Text_IO;
use  Ada.Integer_Text_IO;
with Tableaux;

--Programme de test du module Tableau
procedure Test_Tableaux is

    package Tab_Entier is
            new Tableaux (Capacite  => 7,
                          T_Element => Integer);
    use Tab_Entier;

    procedure carre(e : in out Integer) is --qui met un élement au carré
    begin
        e := e*e;
    end carre;

    procedure zero (e : in out Integer) is --qui met un élement à zéro
    begin
        e := 0;
    end zero ;

    procedure appliquer_carre is new Appliquer_Sur_Chaque(Modifier => carre);
    procedure appliquer_zero is new Appliquer_Sur_Chaque(Modifier => zero) ;

    --Initialiser le tableau et ajouter les élements 4, 3, 1, 3 et 5 de l'exemple
    procedure Initialiser_Exemple (Tab : out Tableau) is
    begin
        Initialiser_Tableau (Tab) ;
        Ajout_Fin ( Tab, 4);
        Ajout_Fin ( Tab, 3);
        Ajout_Fin ( Tab, 1);
        Ajout_Fin ( Tab, 3);
        Ajout_Fin ( Tab, 5);
        pragma Assert (Taille_Tab(Tab)=5);
    end Initialiser_Exemple;


    procedure Tester_Taille is
        Tab : Tableau ;
        N : Integer ;
    begin
        Initialiser_Exemple (Tab) ;
        N := Taille_Tab(Tab);
        pragma Assert (N=5) ;
    end Tester_Taille ;

    procedure Tester_Present is
        Tab : Tableau ;
        T1,T2 : Boolean ;
    begin
        Initialiser_Exemple (Tab) ;
        T1 := Est_Present (Tab,3) ;
        pragma Assert ( T1= True) ;
        T2 := Est_Present (Tab,9) ;
        pragma Assert (T2=False) ;
    end Tester_Present ;

    procedure Tester_Ajout is
        Tab: Tableau ;
    begin
        Initialiser_Exemple (Tab) ;
        Ajout_Indice (Tab, 8, 2);
        pragma Assert (Element_Indice (Tab , 2) = 8);
        Ajout_Indice (Tab, 6, 5);
        pragma Assert (Element_Indice (Tab, 5) = 6);
    end Tester_Ajout;

    procedure Tester_Supprimer is
        Tab : Tableau ;
    begin
        Initialiser_Exemple (Tab) ;
        Supprimer_Indice (Tab,1);
        Supprimer_Indice (Tab,3);
        pragma Assert (Taille_Tab(Tab)=3);
    end Tester_Supprimer ;


    procedure Tester_Supprimer_Tous is
        Tab: Tableau;
    begin
        Initialiser_Exemple (Tab);
        Ajout_Fin (Tab, 1) ;
        Supprimer_Repetition (Tab ,3) ;
        Supprimer_Repetition (Tab ,1) ;
        pragma Assert (not Est_Present (Tab,3)) ;
        pragma Assert (not Est_Present (Tab,1)) ;
    end Tester_Supprimer_Tous ;

    procedure Tester_Appliquer is
        Tab : Tableau ;
    begin
        Initialiser_Exemple (Tab) ;
        appliquer_carre(Tab) ;
        appliquer_zero (Tab) ;
    end Tester_Appliquer;



begin
    Tester_Taille;
    Tester_Present;
    Tester_Ajout;
    Tester_Supprimer;
    Tester_Supprimer_Tous;
    Tester_Appliquer;
end Test_Tableaux;
