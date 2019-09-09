
-- Auteur: Ky Joël Roman 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);


    type T_Stock is limited private;
    
    type T_Stock is record
        Taille : Integer; --nombre de materiels dans le stock
        Materiel : Tab_materiel;
        --Invariant
        --         Taille >= 0
    end record;
    
    
    type Tab_materiel is array (1..CAPACITE) of T_Materiel;
    
    type T_Materiel is record 
        Nature : T_nature ;
        Numero_Serie : Integer ;
        Annee_Achat : Integer ;
        Etat : Booleen;
        --Invariant:
        --         annee_achat >= 0
        --         numero_serie >= 0
    end record;
    
        

    -- Créer un stock vide.
    -- paramètres
    --     Stock : le stock à créer
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels hors d'usage dans le stock Stock
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    -- Nécessite
    --     Vrai
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;


    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;
    
    --Nom: Supprimer
    --Supprimer un materiel a partir de son numero de serie
    --Paramètres:
    --          Stock: le stock à partir duquel on effectue la suppression
    --          Numero_Serie:  le numero de serie du stock à supprimer
    --Necessite:
    --         Nb_Materiels (Stock) > 0
    --Assure:
    --         Nb_Materiels (Stock) = Nb_Materiels(stock)'Avant- 1
    procedure Supprimer (
                         Stock      : in out T_Stock;
                         Numero_Serie : in Integer;
                        ) with
            Pre => Nb_Materiels(Stock) > 0
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old -1;
    
    
    --Nom: Afficher_Tous
    --Afficher tous les matériels du stock
    --Parametres:
    --           Stock: le stock dont on souhaite afficher les matériels
    --Necessite:
    --          Nb_Materiels(Stock) > 0
    procedure Afficher_Tous(
                            Stock: in T_Stock) with
            Pre => Nb_Materiels(Stock)>0;
    
    
    
            

end Stocks_Materiel;
