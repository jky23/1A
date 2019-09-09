with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

-- Objectif : Afficher un tableau trié suivant le principe du tri par sélection.

procedure Tri_Selection is

    CAPACITE: constant Integer := 10;   -- la capacité du tableau

    type Tableau_Entier is array (1..CAPACITE) of Integer;

    type Tableau is
        record
            Elements : Tableau_Entier;
            Taille   : Integer;         --{ Taille in [0..CAPACITE] }
        end record;


    -- Objectif : Afficher le tableau Tab.
    -- Paramètres :
    --     Tab : le tableau à afficher
    -- Nécessite : ---
    -- Assure : Le tableau est affiché.
    procedure Afficher (Tab : in Tableau) is
    begin
        Put ("[");
        if Tab.Taille > 0 then
            -- Afficher le premier élément
            Put (Tab.Elements (1), 1);

            -- Afficher les autres éléments
            for Indice in 2..Tab.Taille loop
                Put (", ");
                Put (Tab.Elements (Indice), 1);
            end loop;
        end if;
        Put ("]");
    end Afficher;


    Tab1 : Tableau;




    procedure Trier (Tab1 : in out Tableau) is
        j : Integer;
        min : Integer;
        Temp : Integer;
    begin
        j := 0 ;


        --debuter le tri du tableau
         for Indice in 1..Tab1.Taille loop
            min := Tab1.Elements (Indice);-- Choisir l'element de position Indice comme valeur minimale du tableau
            for Ind in Indice..Tab1.Taille loop
                if Tab1.Elements (Ind) < min then
                    min := Tab1.Elements (Ind);   -- Remplacer min par la valeur trouvée
                    j := Ind;
                end if;
            end loop;
            Temp := Tab1.Elements( Indice);
            Tab1.Elements(Indice) := Tab1.Elements(j);
            Tab1.Elements(j) := Temp;
        end loop;
    end Trier;


begin
    -- Initialiser le tableau
    Tab1 := ( (1, 3, 4, 2, others => 0), 4);

    -- Afficher le tableau
    Afficher (Tab1);
    New_Line;

    --Trier le tableau
    Trier(Tab1);

    --Afficher le tableau trié
    Afficher (Tab1);
end Tri_Selection;
