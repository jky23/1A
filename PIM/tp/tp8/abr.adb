with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


    procedure Initialiser(Abr: out T_ABR) is
    begin
        Abr := null;
    end Initialiser;



    function Est_Vide (Abr : T_Abr) return Boolean is
    begin
        return (Abr = null);
    end;



    function Taille (Abr : in T_ABR) return Integer is
    begin
        if (Abr = null) then
            return 0;
        elsif Abr.all.Sous_Arbre_Gauche = null then
            return 1 + Taille( Abr.all.Sous_Arbre_Droit);
        elsif Abr.all.Sous_Arbre_Droit = null then
            return 1 + Taille ( Abr.all.Sous_Arbre_Gauche);
        else
            return 1 + Taille(Abr.all.Sous_Arbre_Gauche) + Taille( Abr.all.Sous_Arbre_Droit);
        end if;

    end Taille;



    procedure Inserer (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
    begin
        if Abr.all.Sous_Arbre_Gauche = null and Abr.all.Sous_Arbre_Droit = null then
            if Abr.all.Cle < Cle then
                Abr.all.Sous_Arbre_Droit.all.Cle := Cle;
                Abr.all.Sous_Arbre_Droit.all.Donnee := Donnee;
            else
                Abr.all.Sous_Arbre_Gauche.all.Cle := Cle;
                Abr.all.Sous_Arbre_Gauche.all.Donnee:= Donnee;
            end if;
        elsif Abr.all.Cle = Cle then
            raise Cle_Presente_Exception;

        elsif Abr.all.Cle < Cle then
            Inserer ( Abr.all.Sous_Arbre_Droit , Cle , Donnee);
        elsif Abr.all.Cle > Cle then
            Inserer ( Abr.all.Sous_Arbre_Gauche , Cle , Donnee);
        end if;

    end Inserer;



    procedure Modifier (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
    begin
        if Abr.all.Cle = Cle then
            Abr.all.Donnee := Donnee;

        elsif Abr.all.Cle < Cle then
            if Abr.all.Sous_Arbre_Droit = null then
                raise Cle_Absente_Exception;
            else
                Modifier(Abr.all.Sous_Arbre_Droit,Cle,Donnee);
            end if;

         elsif Abr.all.Cle > Cle then
            if Abr.all.Sous_Arbre_Gauche = null then
                raise Cle_Absente_Exception;
            else
                Modifier (Abr.all.Sous_Arbre_Gauche,Cle,Donnee);
            end if;
        end if;
    end Modifier;




    function La_Donnee (Abr : in T_ABR ; Cle : in Character) return Integer is
    begin
        if Abr.all.Cle = Cle then
            return Abr.all.Donnee;
        elsif Abr.all.Cle < Cle then
            if Abr.all.Sous_Arbre_Droit = null then
                raise Cle_Absente_Exception;
            else
                return La_Donnee(Abr.all.Sous_Arbre_Droit, Cle);
            end if;
        elsif Abr.all.Cle > Cle then
            if Abr.all.Sous_Arbre_Gauche = null then
                raise Cle_Absente_Exception;
            else
                return La_Donnee ( Abr.all.Sous_Arbre_Gauche, Cle);
            end if;
        end if;

    end La_Donnee;



    procedure Supprimer (Abr : in out T_ABR ; Cle : in Character) is
        function max_abrg(Abr : in T_ABR) return T_ABR is
        begin
            if Abr.all.Sous_Arbre_Droit = null then
                return Abr;
            else
                return max_abrg(Abr.all.Sous_Arbre_Droit);
            end if;
        end max_abrg;

       -- T : T_Abr;


    begin
        --if Abr.all.Cle = Cle then
          --  if Abr.all.Sous_Arbre_Gauche = null and Abr.all.Sous_Arbre_Droit = null then
            --    Free (Abr);
           -- elsif Abr.all.Sous_Arbre_Droit = null then
             --   Abr := new T_Noeud'(Abr.all.Sous_Arbre_Gauche.Cle,Abr.all.Sous_Arbre_Gauche.Donnee,null,null);
            --elsif Abr.all.Sous_Arbre_Gauche = null then
              --  null;
           -- else
             --   T := max_abrg(Abr.all.Sous_Arbre_Gauche);
               -- free(max_abrg(Abr.all.Sous_Arbre_Gauche));
                null;


	end Supprimer;


    procedure Vider (Abr : in out T_ABR) is
    begin
		Null;	-- TODO : à changer
	end Vider;


    procedure Afficher (Abr : in T_Abr) is
    begin
        null;


	end Afficher;


    procedure Afficher_Debug (Abr : in T_Abr) is
    begin
		Null;	-- TODO : à changer
	end Afficher_Debug;

end ABR;
