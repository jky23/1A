with Arbre;use Arbre;
with Liste_arbre; use Liste_arbre;
with Chaine; use Chaine;
with Tab_freq; use Tab_freq;
with Table_code; use Table_code;
with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Sequential_Io;

procedure compress is

    
    --package pour lire et ecrire des donnees binaires dans un fichier
    package Bin_IO is new Ada.Sequential_IO(t_bit);
    use Bin_IO;
	
    --package pour lire et ecrire le type modulaire t_bit 
    --sur les entrees/sorties standard
    package ES_IO is new Ada.Text_IO.Modular_IO(t_bit);
    use ES_IO;
	
	
	
    Tab_frequence : P_Tab_Freq;  --Table de frequence
    Tab_code : P_code;     --Table de Huffman
    listes_arbres : T_list_arb; 	--listes contenant les noeuds formes a partir de la table de frequence
    ieme_char, un_char : Character;		--Variables de types caracteres a utiliser
    arbre_somme, arbre_huffman : P_arb;    --respectivement une variable de type P_arb et l'arbre de Huffman
    code, liste_char, descript_arbre : P_string;
    taille_arbre, taille_fichier, ASCII, compteur : Integer;
    binaire : t_bit;                 --variable de type binaire
    file : Bin_Io.File_Type;  --descripteur de fichier binaire
    texte : Ada.Text_IO.file_type; --descripteur de fichier texete

	
begin
    Initialiser_Tab(Tab_frequence);
    taille_fichier := 0;
	
    --Parcourir le texte tout en remplissant la table de frequence
    if Argument_Count >=1 then
        open(texte, In_File, Argument(1));
        loop
            if not end_of_file(texte) then
                if  end_of_line(texte) then -- ******************************
                    un_char := Character'Val(13); -- ************************************************
                    Skip_line(texte); -- ********************************************************
                else -- *******************************************************************
                    Get(texte,un_char);
                end if; -- ***********************************************************
                Ajouter_Caractere(Tab_frequence, un_char);
            end if;
            exit when end_of_file(texte);
        end loop;
        close(texte);
    end if;
    --la table de frequence est faite a cette etape
	
	
    --construire la liste d'arbre a partir de la table de frequences
    Initialiser_list_arb(listes_arbres);
    for i in 1..Taille(Tab_frequence) loop
        ieme_char := Ieme_Caractere(Tab_frequence, i);
        taille_fichier := taille_fichier + Frequence_Du_Caractere(Tab_frequence,ieme_char);
        Placer_croissant(listes_arbres, Creer_noeud(Frequence_Du_Caractere(Tab_frequence,ieme_char),ieme_char));
    end loop;
    --la liste d'arbres est ainsi créée et on a aussi la taille du fichier texte
	
	
    --Construction de l'arbre de Huffman
    while Taille_liste(listes_arbres) >1 loop
        arbre_somme := Somme_premier(listes_arbres);
        Detruire_prem_arb(listes_arbres);
        Detruire_prem_arb(listes_arbres);
        Placer_croissant(listes_arbres, arbre_somme);
    end loop;
    arbre_huffman := Get_arb(listes_arbres);
    --l'arbre de Huffman est ainsi créé
	
    --Construction de la table de Huffman
    Initialiser_chaine(code);
    Initialiser_Table(Tab_code);
    Creer_Table(Tab_code, arbre_huffman, code);
    --La table de Huffman est ainsi créee
	
    --Debut de l'enregitrement des caracteres binaires dans le fichier .hf
    create(file, Out_file, "texte.txt.hf");
	
    --Coder la taille du fichier
    for i in reverse 0..31 loop
        if taille_fichier >= 2**i then
            binaire := 1;
            taille_fichier := taille_fichier - 2**i;
        else
            binaire := 0;
        end if;
        Bin_IO.write(file,binaire);
    end loop;
    close(file);
	
			
	
    --Coder la taille de l'arbre tout en l'inscrivant dans le fichier
    taille_arbre := Taille(Tab_code);
    open(file, Append_File, "texte.txt.hf");
    for i in reverse 0..7 loop
        if taille_arbre >= 2**i then
            binaire := 1;
            taille_arbre := taille_arbre - 2**i;
        else
            binaire := 0;
        end if;
        Bin_IO.write(file, binaire);
    end loop;
    --Code de la taille ajouté dans l'arbre
    close(file);
	
    --Obtenir la liste des caracteres de l'arbre de Huffman obtenue par parcours infixe
    Initialiser_chaine(liste_char);
    Get_list_caract(arbre_huffman,liste_char);
    open(file,Append_File, "texte.txt.hf");
    --convertir les caracteres en ascii puis en binaire et les ajouter dans le fichier
    while not Vide_chaine(liste_char) loop
        ASCII := Character'Pos (Get_prem_caract(liste_char));
        Supprimer_prem_carac(liste_char);
        for i in reverse 0..7 loop
            if ASCII >= 2**i then
                binaire := 1;
                ASCII := ASCII - 2**i;
            else
                binaire := 0;
            end if;
            Bin_IO.Write(file, binaire);
        end loop;
    end loop;
    close(file);
	
  
	
	
	
    --Obtenir la description de l'arbre
    Initialiser_chaine(descript_arbre);
    Descrip_arbre(arbre_huffman, descript_arbre,taille_arbre); 
    open(file, Append_File, "texte.txt.hf");
	
    --Inscrire la description de l'arbre dans le fichier
    while not Vide_chaine(descript_arbre) loop
        binaire := Recup_binaire(descript_arbre);
        Supprimer_prem_carac(descript_arbre);
        Bin_IO.write(file,binaire);
    end loop;
    --Description ajoutée dans l'arbre
    close(file);
	
	
	
    --Substituer chaque caractere du fichier texte par son code de Huffman et l'ajouter dans le texte
	
    open(texte, In_File,Argument(1));
    open(file, Append_File, "texte.txt.hf");
    loop
		
        if not end_of_file(texte) then
            if end_of_line(texte) then -- ***********************************************
                un_char := Character'Val(13); -- **************************************
                skip_line(texte); -- **********************************************
            else -- ****************************************************
                Get(texte,un_char);
            end if; -- *****************************************************
            code := Code_Par_Caractere(Tab_code,un_char);
            while not Vide_chaine(code) loop
                binaire := Recup_binaire(code);
                Supprimer_prem_carac(code);
                Bin_IO.write(file,binaire);
            end loop;
        end if; 		
		
        exit when end_of_file(texte);
    end loop;
    close(file);
    close(texte);
    -- Tous les caracteres du texte ont ete inseres
    compteur := 0;
    Afficher_arbre(arbre_huffman, compteur);
    Afficher(Tab_code);
    
	
end compress;
