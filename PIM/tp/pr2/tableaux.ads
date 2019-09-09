--KY Joël Roman
--Groupe M

--Spécification du module Tableaux

generic
    Capacite : Integer;        --Nombre maximal d'éléments que peut ontenir le tableau
    type T_Element is private;  -- type des elements du Tableau

package Tableaux is

    type Tableau is limited private;--le type Tableau ne sera pas accessible aux utilisateurs du module

    --Initialiser_Tableau
    --Mettre la taille du tableau à 0
    --Parametre :
    --          Tableau : le tableau à initialiser
    --Necessite: Vrai
    --Assure : Taille_Tab(Tableau) = 0
    procedure Initialiser_Tableau ( Tab : out Tableau) with
            Post => Taille_Tab(Tab) = 0;



    --Taille_Tab
    --Obtenir la taille du tableau
    --Parametres :
    --           Tableau : le tableau dont on cherche la taille
    --Necessite: Vrai
    --Assure : Resultat >= 0 Et Resultat <= Capacite
    function Taille_Tab (Tab : in Tableau) return Integer with
            Post => Taille_Tab'Result >= 0 and Taille_Tab'Result <= Capacite ;


    --Element_Indice
    --Obtenir l'élément à un indice valide du tableau
    --Paramètres :
    --            Tableau : le tableau où rechercher l'élément
    --            Indice : l'indice de l'élement recherché
    --Necessite :
    --          Taille_Tab(Tableau) >0 Et Indice>=1 et Indice<= Taille_Tab(Tableau)
    --Assure :
    function Element_Indice( Tab : in Tableau;
                             Indice : in Integer) return T_Element with
            Pre => Taille_Tab(Tab) >0 and Indice >=1 and Indice <= Taille_Tab(Tab) ;


    --Modifier_Element
    --Modifier l'élement à un indice valide du tableau
    --Paramètres :
    --           Tableau : le tableau où on souhaite effectuer la modification
    --           Indice: l'indice de l'element que l'on souhaite modifier
    --           Element: le nouveau élément
    --Necessite :
    --          Taille_Tab(Tableau) >0 Et Indice>=1 et Indice<= Taille_Tab(Tableau)
    --Assure :
    procedure Modifier_Element ( Tab : in out Tableau;
                                 Indice : in Integer;
                                Element : in T_Element) with
            Pre => Taille_Tab(Tab) >0 and Indice >=1 and Indice <= Taille_TAb(Tab) ;


    --Ajout_Fin
    --Ajouter un élément en fin de tableau
    --Paramètres:
    --           Tableau : Tableau a modifier
    --           Element : Element à ajouter à la fin
    --Necessite : Taille_Tab(Tableau) < Capacite
    --Assure :
    --        Element ajouté
    --        Taille_Tab(Tab) = Taille_Tab(Tab)'Avant +1
    procedure Ajout_Fin ( Tab : in out Tableau;
                          Element : in T_Element) with
            Pre => Taille_Tab(Tab) < Capacite,
            Post => Taille_Tab(Tab) = Taille_Tab(Tab)'Old +1;


    --Est_Present
    --Savoir si un élément est présent dans le tableau
    --Paramètres:
    --           Tableau : le tableau où effectuer la recherche
    --           Element : Element recherché
    --Necessite : Taille_Tab(Tableau) >0
    function Est_Present( Tab : in Tableau;
                          Element : in T_Element) return Boolean with
            Pre => Taille_Tab(Tab) >0 ;

    --Ajout_Indice
    --Ajouter un element a un indice donné du tableau qui ne doit pas avoir atteint sa capacité max
    --Paramètres:
    --          Tableau : le tableau a modifier
    --          Element : élement à ajouter
    --          Indice : indice de l'élement dans le tableau
    --Necessite: Taille_Tab(Tableau)< Capacite
    --Assure : Taille_Tab(Tableau) = Taille_Tab(Tableau)'Avant +1
    procedure Ajout_Indice ( Tab : in out Tableau;
                             Element: in T_Element;
                             Indice : in Integer) with
            Pre => Taille_Tab(Tab) < Capacite,
            Post => Taille_Tab(Tab) = Taille_Tab(Tab)'Old +1;

    --Supprimer_Indice
    --Supprimer un élement à un indice donné du tableau
    --Paramètres:
    --          Tableau : tableau à modifier
    --          Indice : Indice de l'élement à supprimer
    --Necessite: Taille_Tab(Tableau) >0
    --Assure : Taille_Tab(Tableau) = Taille_Tab(Tableau)'Avant -1
    procedure Supprimer_Indice( Tab : in out Tableau;
                                Indice : in Integer) with
            Pre => Taille_Tab(Tab) >0,
            Post => Taille_Tab(Tab) = Taille_Tab(Tab)'Old -1;


    --Supprimer_Repetition
    --Supprimer toutes les occurences d'un élement dans le tableau
    --Paramètres:
    --          Tableau : tableau à modifier
    --          Element : élement à supprimer
    --Necessite : Taille_Tab(Tableau) >0
    --Assure :non Est_Present(Tableau,Element)
    procedure Supprimer_Repetition ( Tab : in out Tableau;
                                     Element : in T_Element) with
            Pre => Taille_Tab(Tab) >0,
            Post => not Est_Present(Tab,Element);


    --Appliquer_Sur_Chaque
    --Effectuer une opération sur chaque élement du tableau
    generic
        with procedure Modifier(Element : in out T_Element);
    procedure Appliquer_Sur_Chaque(Tab : in out Tableau);






private

    type T_Tab_Elements is array (1..Capacite) of T_Element;  -- le tableau de T_elements

    type Tableau is record   --enregistrement du tableau et de sa taille
        Tableau_Element : T_Tab_Elements;   --le tableau d'éléments
        Taille : Integer;  --la taille du tableau
        --Invariant:
        --          Taille >=0
    end record;
end Tableaux ;
