with Ada.Text_IO;
use Ada.Text_IO;

-- Dans ce programme, les commentaires de spécification
-- ont **volontairement** été omis !

procedure Comprendre_Mode_Parametre is

    function Double (N : in Integer) return Integer is
    begin
        return 2 * N;
    end Double;
    -- Calcul et retourne le double d'un entier N saisi

    procedure Incrementer (N : in out Integer) is
    begin
        N := N + 1;
    end Incrementer;
    -- modifie la valeur d'un entier saisi par l'entier consécutif

    procedure Mettre_A_Zero (N : out Integer) is
    begin
        N := 0;
    end Mettre_A_Zero;
    -- modifie la valeur d'un entier saisi par zéro

    procedure Comprendre_Les_Contraintes_Sur_L_Appelant is
        A, B, R : Integer;
    begin
        A := 5;
        -- Indiquer pour chacune des instructions suivantes si elles sont
        -- acceptées par le compilateur.
        R := Double (A);
        --Accepté car A est un entier
        R := Double (10);
        --autorisé
        R := Double (10 * A);
        -- autorisé
        R := Double (B);
        -- autorisé

        Incrementer (A);
        --Accepté car A est un entier
        Incrementer (10);
        --Refusé car 10 ne peut pas etre modifié

        Incrementer (10 * A);
        -- Refusé car 10*A ne peut pas etre modifié
        Incrementer (B);
        -- autorisé

        Mettre_A_Zero (A);
        --Accepté
        Mettre_A_Zero (10);
        --Refusé car 10 n'est pas une variable
        Mettre_A_Zero (10 * A);
        --Refusé car n'est pas une variable
        Mettre_A_Zero (B);
        --Accepté mais B n'est pas défini
    end Comprendre_Les_Contraintes_Sur_L_Appelant;


    procedure Comprendre_Les_Contrainte_Dans_Le_Corps (
            A      : in Integer;
            B1, B2 : in out Integer;
            C1, C2 : out Integer)
    is
        L: Integer;
    begin
        -- pour chaque affectation suivante indiquer si elle est autorisée
        --Autorisé
        A := 1;
        --non autorisé car A est une donnée In et ne peut être modifié

        B1 := 5;
        --autorisé car B est un resultat Out

        L := B2;
        --non autorisé car B2 est un resultat Out
        B2 := B2 + 1;
        --non autorisé car B2 est une resultat Out

        C1 := L;
        --autorisé car C1 peut être modifié

        -- non autorisé C2 est une resultat Out

        C2 := A;
        --aurorisé
        C2 := C2 + 1;
        --non autorisé car C2 est un resultat Out
    end Comprendre_Les_Contrainte_Dans_Le_Corps;


begin
    Comprendre_Les_Contraintes_Sur_L_Appelant;
end Comprendre_Mode_Parametre;
