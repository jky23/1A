with Piles;
with Ada.Text_IO;            use Ada.Text_IO;

-- Montrer le risque d'autoriser l'affectation entre variables dont le type
-- est une structure chaînée.
procedure Illustrer_Affectation_Pile is
	package Pile is
		new Piles (Character);
	use Pile;

	procedure Afficher is
		new Pile.Afficher (Put);

	P1, P2 : T_Pile;
begin
	-- construire la pile P1
	Initialiser (P1);
	Empiler (P1, 'A');
	Empiler (P1, 'B');
	Afficher (P1); New_Line;   -- XXX Qu'est ce qui s'affiche ? on affichera A , B

	--P2 := P1;                  -- XXX Conseillé ? Non car la modification de P1 modifiera P2 car ce sont des pointeurs
	--pragma Assert (P1 = P2);

	--Depiler (P2);              -- XXX Quel effet ?  le sommet de P2 et de P1 sera modifier
	--Afficher (P2); New_Line;   -- XXX Qu'est ce qui s'affiche ? A
	Afficher (P1); New_Line;   -- XXX Qu'est ce qui s'affiche ? A , B
	-- XXX Que donne l'exécution avec valkyrie ?

        Depiler (P1);	-- XXX correct ? Non
        Detruire (P1);

end Illustrer_Affectation_Pile;
