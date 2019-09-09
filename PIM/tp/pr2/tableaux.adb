--KY Joël Roman
--Groupe M

--Implantation du module Tableaux

with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Integer_Text_IO;
use  Ada.Integer_Text_IO;

package body Tableaux is

    procedure Initialiser_Tableau ( Tab : out Tableau) is
    begin
        Tab.Taille := 0 ;
        Null;
    end Initialiser_Tableau;

    function Taille_Tab( Tab : in Tableau) return Integer is
    begin
        return Tab.Taille ;
    end Taille_Tab;

    function Element_Indice ( Tab : in Tableau;
                             Indice : in Integer) return T_Element is
    begin
        return Tab.Tableau_Element(Indice);
    end Element_Indice;


    procedure Modifier_Element (Tab : in out Tableau;
                                Indice : in Integer;
                               Element : in T_Element) is
    begin
        Tab.Tableau_Element(Indice) := Element ;
    end Modifier_Element;

    procedure Ajout_Fin ( Tab : in out Tableau;
                          Element : in T_Element) is
    begin
        Tab.Taille := Tab.Taille + 1 ;
        Tab.Tableau_Element(Taille_Tab(Tab)) := Element ;
        Null;
    end Ajout_Fin;


    function Est_Present ( Tab : in Tableau;
                           Element : in T_Element) return Boolean is
        T : Boolean;
    begin
        T := False ;
        for k in 1..Tab.Taille loop
            if Tab.Tableau_Element(k)= Element then
                T := True ;
            else
                null;
            end if;
        end loop;
        return T ;
    end Est_Present;

    procedure Ajout_Indice ( Tab : in out Tableau;
                             Element : in T_Element;
                             Indice : in Integer) is
    begin
        Tab.Taille := Tab.Taille + 1;
        for k in (Tab.Taille - 1)..Indice loop
            Tab.Tableau_Element(k+1) := Tab.Tableau_Element(k) ;
        end loop;
        Tab.Tableau_Element(Indice) := Element ;
    end Ajout_Indice;



    procedure Supprimer_Indice ( Tab : in out Tableau;
                                 Indice : in Integer) is
    begin
        for k in Indice+1..Tab.Taille loop
            Tab.Tableau_Element(k-1) := Tab.Tableau_Element(k) ;
        end loop ;
        Tab.Taille := Tab.Taille -1 ;
        null;
    end Supprimer_Indice;


    procedure Supprimer_Repetition ( Tab : in out Tableau;
                                     Element : in T_Element) is
        newTab : Tableau ;
        Elt : T_Element ;
    begin
        Initialiser_Tableau (newTab) ;
        for k  in 1..Taille_Tab(Tab) loop
            Elt := Tab.Tableau_Element(k) ;
            if Tab.Tableau_Element(k) /= Element then
                Ajout_Fin (newTab,Elt) ;
            else
                null;
            end if ;
        end loop ;
        Tab := newTab ;
    end Supprimer_Repetition;


    procedure Appliquer_Sur_Chaque ( Tab : in out Tableau) is
        e : T_Element ;
    begin
        for k in 1..Taille_Tab(Tab) loop
            e := Tab.Tableau_Element(k);
            Modifier(e);
            Tab.Tableau_Element(k) := e ;
        end loop;

    end Appliquer_Sur_Chaque;

end Tableaux ;
