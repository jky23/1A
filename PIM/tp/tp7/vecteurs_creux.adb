with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


    procedure Initialiser (V : out T_Vecteur_Creux) is
    begin
        V := Null;


    end Initialiser;



    procedure Detruire (V: in out T_Vecteur_Creux) is
    begin
        if V /= Null then
            Detruire (V.all.Suivant) ;
            Free (V);
        else
            Null;
        end if;
    end Detruire;


    function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
    begin
       	return V = Null;	-
    end Est_Nul;



    function Composante_Recursif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
    begin
        if V.all.Indice = Indice then
            return V.all.Valeur ;
        else
            Composante_Recursif(V.all.Suivant ; Indice);
        end if;
    end Composante_Recursif;




    function Composante_Iteratif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
        W : T_Vecteur_Creux;
    begin
        W := V;
        while W.all.Indice < Indice loop
            W := W.all.Suivant;
        end loop;
        if W.all.Indice = Indice then
            return W.all.Valeur;
        else
            return null;
        end if;
    end Composante_Iteratif;




    procedure Modifier (V : in out T_Vecteur_Creux ;
                        Indice : in Integer ;
                        Valeur : in Float ) is
    begin
        if V.all.Indice = Indice then
            V.all.Valeur := Valeur;
        elsif V.all.Indice > Indice then
            V = new T_Cellule( Indice,Valeur,V);
        else
            Modifier (V.all.Suivant,Indice,Valeur);

    end Modifier;


    function Sont_Egaux_Recursif (V1, V2 : in T_Vecteur_Creux) return Boolean is
    begin
        if V1= null and V2 = null then
            return True;
        elsif V1.all.Valeur /= V2.all.Valeur then
            return False ;
        else
            return Sont_Egaux_Recursif (V1.all.Suivant , V2.all.Suivant);
        end if;
    end Sont_Egaux_Recursif;



    function Sont_Egaux_Iteratif (V1, V2 : in T_Vecteur_Creux) return Boolean is
        W1,W2 : T_Vecteur_Creux ;
    begin
        W1 := V1 ;
        W2 := V2 ;
        while W1 /= null and W2 /= null and then W1.all.Valeur = W2.all.Valeur loop
            W1 := W1.all.Suivant;
            W2 := W2.all.Suivant;
        end loop;
        if W1 = null and W2 = null then
            return True;
        else
            return False;
        end if;
    end Sont_Egaux_Iteratif;



	procedure Additionner (V1 : in out T_Vecteur_Creux; V2 : in T_Vecteur_Creux) is
	begin
		Null;	-- TODO : à changer
	end Additionner;


	function Norme2 (V : in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Norme2;


	Function Produit_Scalaire (V1, V2: in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Produit_Scalaire;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			Put ("-->[ ");
			Put (V.all.Indice, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
