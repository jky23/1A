with Arbre;use Arbre;
with Liste_arbre; use Liste_arbre;
with Chaine; use Chaine;
with Tab_freq; use Tab_freq;
with Table_code; use Table_code;
with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Sequential_IO;

procedure uncompress is
    package Bin_IO is new Ada.Sequential_IO(t_bit);
    use Bin_IO;
    
    --package pour lire et ecrire le type modulaire t_bit 
    --sur les entrees/sorties standard
    package ES_IO is new Ada.Text_IO.Modular_IO(t_bit);
    use ES_IO;

	
    file : Bin_IO.File_Type;
    texte : Ada.Text_IO.file_type;
    binaire : t_bit;
    char : Character;
    taille_texte, taille_arbre, nbre_carac, ascii, compteur : Integer;
    code, liste_char, descrip_arb, code_caract : P_string;
    bool, Premier_caractere: Boolean;
    arb_huffman : P_arb;
    tab_huff : P_code;

begin
    if Argument_Count>=1 then
        --Ouverture du fichier compressé
        open(file, In_File, Argument(1));
        --Recuperer la taille du texte 
        --la taille etant codée sur 32 bits
        taille_texte := 0;
        for i in 0..31 loop
            Bin_IO.Read(file,binaire);
            if binaire = 0 then
                taille_texte := taille_texte*2 ;
            elsif binaire = 1 then
                taille_texte := taille_texte*2 +1;
            end if;
            
        end loop;
    end if;
    --la taille du texte est obtenue 
		
    --recuperer la taille de l'arbre
    --cette taille etant codée sur 8 bits
    taille_arbre := 0 ;
    for i in 0..7 loop
        Bin_IO.Read(file,binaire);
        if binaire = 0 then
            taille_arbre := taille_arbre*2 ;
        elsif binaire = 1 then
            taille_arbre := taille_arbre*2 +1;
        end if;
    end loop;
    --la taille de l'arbre est obtenue
		
    --reconstruire la liste des caracteres de l'arbre
    for i in 1..taille_arbre loop
        --recuperer le code ascii de chaque caractere et l'ajouter
        --le code ascii de chaque caractere etant codé sur 8 bits
        ascii := 0;
        for j in 1..8 loop
            Bin_IO.Read(file,binaire);
            if binaire = 0 then
                ascii := ascii*2 ;
            elsif binaire = 1 then
                ascii := ascii*2 +1;
            end if;
        end loop;
        char := Character'Val(ascii);
        Ajout_caract (liste_char,char);
        --le caractere est reobtenue et ajouter a la liste des caracteres
    end loop;
    --la liste ordonnée des caracteres est ainsi créée
    Afficher_chaine(liste_char);
    New_Line;
		
    --recuperer la description de l'arbre
    nbre_carac := 0;
    while nbre_carac<taille_arbre loop
        Bin_IO.Read(file,binaire);
        if binaire = 0 then
            char :='0';
            Ajout_caract(descrip_arb,char);
            bool := True;
        else 
            char := '1';
            Ajout_caract(descrip_arb,char);
            if bool then
                bool := False;
                nbre_carac := nbre_carac + 1 ;
            else
                null;
            end if;
        end if;
    end loop;
    Afficher_chaine(descrip_arb);
    --on a ainsi recuperer la description de l'arbre
		
		
    --Reconstruire l'arbre de Huffman
    Initialiser_arbre(arb_huffman);
    arb_huffman := Creer_noeud(0,'#');
    Recons_arb(descrip_arb, liste_char, arb_huffman);
    -- L'arbre de Huffman est ainsi créé
		
    --Reconstruire la table de Huffman a partir de l'arbre de Huffman
    Initialiser_chaine(code);
    Initialiser_Table(tab_huff);
    Creer_table(tab_huff,arb_huffman,code);
    -- on obtient alors la table de Huffman
		
    --Decompression du fichier
    create(texte, Out_File, "texte.txt");
    Initialiser_chaine(code_caract);
    Premier_caractere := False;
    --Lire le fichier jusqu'a la fin tout en remplacant chaque code par le caractere correspondant
    while not end_of_file(file) loop
        Bin_IO.Read(file,binaire);
        if binaire = 0 then
            Ajout_caract(code_caract,'0');
        else
            Ajout_caract(code_caract,'1');
        end if;
        --Teste si le chaine de bits recuperes est presente dans la table de Huffman et l'ajoute si tel est le cas 
        if Est_Present_Code(tab_huff,code_caract) then
            char := Caractere_Par_code(tab_huff,code_caract);
            if char = Character'Val(13) then
                new_line(texte);
            else
                if Premier_caractere = True then
                    Put(texte,char);
                else
                    Premier_caractere := True;
                end if;
            end if;
            Supprimer_chaine(code_caract);
            Initialiser_chaine(code_caract);
        else
            null;
        end if;
    end loop;
    close(file);
    close(texte);
    compteur := 0;
    Afficher_arbre(arb_huffman, compteur);
    Afficher(tab_huff);
			
			
				
			
			
			
end uncompress;
