-- KJR -- Il manque les invariants et commentaires sur les types definis 
-- A quoi sert votre liste, et comment allez-vous la manipuler ? Ce n'est pas clair. C'est un tableau statique, il faut donc se souvenir du nb de caracteres qui sera contenu dans le tableau. Non ? 
-- Vous devriez changer les identifiants de vos types 
-- 	Votre noeud est en fait un arbre algorithmiquement parlant. 
-- 	votre arbre est en fait une liste algorithmiquement parlant. 

--Specification de l'interface du module List_arbre
with Arbre; use Arbre;
with Chaine; use Chaine;

package Liste_arbre is
        
    type T_list_arb is private;
                 
    --Initialiser la liste d'arbre
    procedure Initialiser_list_arb ( liste : out T_list_arb) with
            Post => Est_nul_liste (liste);
        
    --Verifie si la liste d'arbre est nulle
    function Est_nul_liste ( liste : in T_list_arb) return Boolean;
    
    --Retourne le premier arbre de la liste d'arbres
    function Get_prem_arb(liste : in T_list_arb) return P_arb with
            Pre => not Est_nul_liste(liste);
        
    -- KJR -- Qu'est-ce que le premier noeud d'un arbre ? Le sommet ? La feuille la plus a gauche ? 
    --Detruire le premier arbre de la liste d'arbres
    procedure Detruire_prem_arb (liste : in out T_list_arb );
        
    -- KJR -- arbre en in out
    --Detruire la liste d'arbres
    procedure Detruire_list_arb (liste : in out T_list_arb) with
            Post => Est_nul_liste (liste);
        
    -- KJR -- Est-ce que vous parlez bien d'un arbre ? On dirait que vous parlez d'une liste ... 
    -- Attention la relation d'ordre sur les frequences est differente de celle du TP pour l'algo de huffman.
    --Placer un arbre au bon endroit de tel sorte que les frequences soient dans l'ordre croissant
    procedure Placer_croissant( liste : in out T_list_arb ; arbre : in P_arb);
    
    --Retourner l'arbre restant quand la liste d'arbre ne comporte qu'un seul arbre
    function Get_arb (liste : in T_list_arb) return P_arb;
    
    --Retourne la taille d'une liste d'arbres
    function Taille_liste (liste : in T_list_arb) return Integer;
    
    --Effectue la somme des deux premiers arbres de la liste d'arbres
    function Somme_premier(liste : in T_list_arb) return P_arb with
            Pre => not(Est_nul_liste(liste));
                
private

    type List_arb;
    type T_list_arb is access List_arb;
    
    type List_arb is record
        Arbre : P_arb;
        Suivant : T_list_arb;
    end record;
		
end Liste_arbre;
