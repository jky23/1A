-- KJR -- Attention à l'indentation
-- Il y a des imprécisions dans vos commentaires. 
-- Il vous manque des SP qui permettent de lire la valeur du caractere et de la frequence. 

with Chaine; use Chaine;
package Arbre is 
				
    type P_arb is private;
		
    --Initialiser un arbre
    procedure Initialiser_arbre ( arbre : out P_arb) with
            Post => Arbre_vide(arbre);
		
    --Verifie si un arbre est vide 
    function Arbre_vide (arbre : in P_arb) return Boolean;
		
				
    --Creer un noeud ( le noeud est un arbre qui a ses deux sous-arbres qui pointent sur null)
    function Creer_noeud (frequence : in Integer ; caractere : in Character) return P_arb;
        
    --Obtenir la valeur du caractere d'un arbre
    function Get_caractere ( arbre : in P_arb) return Character;
			
    --Obtenir la valeur de la frequence d'un arbre
    function Get_frequence (arbre : in P_arb) return Integer;
		
    --Obtenir le sous_arbre gauche
    function Get_gauche (arbre : in P_arb) return P_arb;
		
    --Obtenir le sous_arbre droit
    function Get_droit (arbre : in P_arb) return P_arb;
			
    --Sommer deux arbres et creer un nouveau arbre conformement au principe de l'algorithme de Huffman
    function Sommer_arbre ( arbre1 : in P_arb ; arbre2 : in P_arb) return P_arb with
           Post => Get_frequence (Sommer_arbre'Result) = Get_frequence (arbre1) + Get_frequence (arbre2); 
    --and Get_gauche(Sommer_arbre'Result) = arbre1 and Get_droit(Sommer_arbre'Result) = arbre2;
 
        
    --remplacer la frequence d'un arbre
    procedure Remplacer_frequence (arbre : in P_arb ; frequence : Integer);
        
    --remplacer le caractere d'un arbre
    procedure Remplacer_caractere (arbre : in P_arb ; caractere : Character);
    
    
    --afficher l'arbre de Huffman
    procedure Afficher_arbre (arbre : in P_arb; compteur : in out Integer) ;
        
    -- generer la description de l'arbre
    -- Le Code est en "in" pour le garder en mémoire lors de l'utilisation récursive de la procedure
    procedure Descrip_arbre ( arbre : in P_arb ; Code : in out P_string ; Elements_manquant : in out Integer);
        
    --obtenir une liste des caracteres presents de l'arbre
    procedure Get_list_caract ( arbre : in P_arb; L : in out P_string);
        
    --reconstruire l'arbre à partir de la description et de la liste ordonnée des caracteres
    procedure Recons_arb (code : in out P_string; liste : in out P_string ; arb : in out P_arb);
        

private 
	
    type T_arb;
    type P_arb is access T_arb;
	    
    type T_arb is record 
        Frequence : Integer;
        Caractere : Character;
        Sous_arbre_gauche : P_arb;
        Sous_arbre_droit : P_arb;
        --Invariant
        --Sous_arbre_gauche.all.Frequence <= Sous_arbre_droit.all.Frequence
        --Sous_arbre_gauche = null <=> Sous_arbre_droit = null
    end record;


end Arbre;
