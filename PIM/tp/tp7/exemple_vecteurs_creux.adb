with Ada.Text_IO;       use Ada.Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;

-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

    V : T_Vecteur_Creux;
    T : Boolean;
    W : T_Vecteur_Creux;
begin
    Put_Line ("Début du scénario");
    Initialiser (V);
    Afficher (V) ;

    T := Est_Nul (V);
    pragma Assert (T= True);

    Detruire (V);

    Composante_Recursif( V,18);
    Composante_Iteratif(V,18);

    Initialiser(V);
    Modifier(V,3,5.5);
    Modifier(V,5,36.5);
    Modifier(V,18,3.17);
    Modifier(V,25,9.99);
    pragma Assert ( Composante_Recursif (V,3)=5.5);
    pragma Assert ( Composante_Recursif (V,5)=36.5);
    pragma Assert ( Composante_Recursif (V,18)=3.17);
    pragma Assert ( Composante_Recursif (V,25)=9.99);
    Detruire (V);

    Initialiser(V);
    Initialiser(W);
    Modifier(V,3,5.5);
    Modifier(V,5,36.5);
    Modifier(V,18,3.17);
    Modifier(V,25,9.99);

    Modifier(W,3,5.5);
    Modifier(W,5,36.5);
    Modifier(W,18,3.17);
    Modifier(W,25,9.99);
    pragma Assert ( Sont_Egaux_Recursif(V,W));

    Modifier(W,25,8.99);
    pragma Assert ( not Sont_Egaux_Iteratif(V,W));
    Detruire(V);
    Detruire(W);




	Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;
