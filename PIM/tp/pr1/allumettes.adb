with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Alea;

--------------------------------------------------------------------------------
--  Auteur   :Ky Joël Roman
--  Objectif :
--------------------------------------------------------------------------------

procedure Allumettes is
    Niveau : Character; --Niveau de l'ordinateur
    J1 : Boolean;  --Joueur qui a la main:True pour l'utilisateur et False pour l'ordinateur
    P : Boolean;
    C : Boolean;
    main : Character; --si l'utilisateur commence ou pas
    n : Integer; --nombre d'allumettes restant a tirer
    al : Integer; --nombre d'allumettes prises a chaque tour
    rejouer : Character;


	package Alea_1_3 is
		new Alea (1, 3);
         use Alea_1_3;


begin
    P := True; --Suppose que l'utilisateur veut jouer

    loop
        --Choix du niveau de l'ordinateur
	Put("Niveau de l'ordinateur (n)aif, (d)istrait, (r)apide ou (e)xpert ? ");
        Get(Niveau);
        Skip_Line;
        case Niveau is
            when 'n'  => Put_Line("Mon niveau est naïf.");
	    when 'd'  => Put_Line("Mon niveau est distrait.");
            when 'r'  => Put_Line("Mon niveau est rapide.");
	    when others => Put_Line("Mon niveau est expert.");
	end case;

	--Choix du Joueur1
        Put("Est-ce que vous commencez (o/n) ? ");

        Get(main);
        Skip_Line;
        New_Line;
        if main='o' then
            J1:= True; --Le joueur a la main
        else
            J1:= False; --L'ordinateur a la main
	end if;

	--Deroulement de la partie
	n:=13;
        while n/=0 loop

	    --Afficher le nombre d'allumettes
            for Indice in 1..3 loop
                --Afficher une rangée d'allumettes
                for Indice in 1..n loop
                    if Indice mod 5 /= 0 then
	                 Put("| ");
                    else
                        Put("|   "); -- afficher un espace apres chaque lot de 5 allumettes
	            end if;
                end loop;
                New_Line;
            end loop;
            New_Line;

            if J1 then
                --L'utilisateur choisit un nombre d'allumettes et le jeu se poursuit si le nombre d'allumettes choisit convient avec les regles du jeu
                loop  --demander a l'utilisateur combien d'allumettes il choisit jusqu'a ce que ce soit correct
                    Put("Combien d'allumettes prenez-vous ? ");

                    Get(al);
                    Skip_Line;
                    New_Line;
                    C:= True; -- Suppose que le joueur a bien choisi le nombre d'allumettes
                    if al>3 then
                        Put_Line("La prise est limitée à 3 maximum !");
		        C:= False;
                    elsif al>n then
                        if n>1 then
                            Put_Line("Il reste seulement" & Integer'Image(al)& " allumettes.");
                        elsif n=1 then
                            Put_Line("Il reste une seule allumette.");
                        end if;
                        C:=False;
                    else
                        Null;
                    end if;
                exit when C; --on sort de la boucle quand le choix du nombre d'allumettes sera correct
                end loop;
                n:= n-al; --actualiser le nombre d'allumettes restant
                J1:= False;
            else
                --L'ordinateur choisit un nombre d'allumettes en fonction du niveau choisi
                case Niveau is
                    --l'ordinateur joue en mode naif
                    when 'n' =>
                        if n>3 then
                            Get_Random_Number (al); --appel de la fonction qui choisit un nombre aleatoire
                        elsif n<=3 then
                            loop --le choix du nombre aleatoire se repete jusqu'à ce que le nombre soit correct
                                Get_Random_Number (al);
                            exit when al<=n;
                            end loop;
                        else
                            Null;
                        end if;


                        -- l'ordinateur joue en mode distrait
                    when 'd' =>
                        loop  --repetition du choix du nombre aleatoire jusqu'a ce que ce soit correct
                            Get_Random_Number(al);
                        exit when al<=n and al<=3;
                        end loop;
                        --l'ordinateur joue en mode rapide
                    when 'r' =>
                        if n>3 then
                                       al:=3;
                        else
                                       al:=n;
                        end if;

                        --l'ordinateur joue en mode expert
                    when others =>
                        if n=1 then
                                     al:= 1;
                        else
                            case (n mod 4) is
                                when 0 =>
                                    al := 3;
                                when 1 =>
                                    al := 1;
                                when 2 =>
                                    al := 1;
                                when 3 =>
                                    al := 2;
                                when others =>
                                    Null;
                            end case;
                         end if;

                end case;
                n := n-al; --modification du nombre d'allumettes restant
                J1:= True; --l'ordinateur passe la main à l'utilisateur
                if al=1 then
                    Put_Line("Je prends une allumette.");
                    New_Line;
                else
                    Put_Line("Je prends " &Integer'Image(al)&" allumettes.");
                    New_Line;
                end if;





            end if;
        end loop;

        --Afficher le vainqueur
        if J1= True then
            Put_Line("Vous avez gagné.");
        else
            Put_Line("J'ai gagné !");
        end if;
        Put_Line("Voulez-vous rejouer ? (o)ui ou (n)on");  --Demande à l'utilisateur si il veut rejouer
        Get(rejouer);
        Skip_Line;
        if rejouer='o'  then
            P := True;
        elsif rejouer='n' then
            P := False;
        else
            Put("Je n'ai pas compris votre message, le choix seraa alors non");
            P := False;
        end if;
    exit when not P; --le jeu se termines si l'utilisateur ne veut plus rejouer
    end loop;


end Allumettes;
