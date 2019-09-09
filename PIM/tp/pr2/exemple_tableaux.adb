--KY Joël Roman
--Groupe M

with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Integer_Text_IO;
use  Ada.Integer_Text_IO;
with Tableaux;



procedure exemple_tableaux is
    package Tab_Character is new Tableaux( Capacite => 15, T_Element => Character ) ;
    package Tab_Float is new Tableaux ( Capacite => 50 , T_Element => Float ) ;
    use Tab_Float;
    use Tab_Character;

    procedure carre(e : in out Float) is --qui met un élement au carré
    begin
        e := e*e;
    end carre;
    procedure appliquer_carre is new Tab_Float.Appliquer_Sur_Chaque(Modifier => carre);


    procedure aa( e : in out Character) is --qui remplace un élement par la lettre A
    begin
        e := 'A' ;
    end aa ;
    procedure appliquer_aa is new Tab_Character.Appliquer_Sur_Chaque(Modifier => aa) ;

    procedure initialiser_float (Tab : out Tab_Float.Tableau) is
    begin
        Initialiser_Tableau (Tab) ;
        Ajout_Fin ( Tab, 4.5);
        Ajout_Fin ( Tab, -3.54);
        Ajout_Fin ( Tab, 1.8944);
        Ajout_Fin ( Tab, 3.1667);
        Ajout_Fin ( Tab, 5.0);
        pragma Assert (Taille_Tab(Tab)=5);
    end initialiser_float;




    procedure initialiser_character (Tab : out Tab_Character.Tableau) is
    begin
        Initialiser_Tableau (Tab) ;
        Ajout_Fin ( Tab, 'e');
        Ajout_Fin ( Tab, 'p');
        Ajout_Fin ( Tab, 'A');
        Ajout_Fin ( Tab, 'p');
        Ajout_Fin ( Tab, 'Z');
        pragma Assert (Taille_Tab(Tab)=5);
    end initialiser_character;

    T2 : Tab_Character.Tableau;
    T1 : Tab_Float.Tableau;


begin
    initialiser_float(T1);
    initialiser_character(T2);
    appliquer_aa(T2);
    appliquer_carre(T1);
end exemple_tableaux;
