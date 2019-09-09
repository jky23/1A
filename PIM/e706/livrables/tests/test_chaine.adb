with Chaine; use Chaine;
with Ada.Text_Io; use Ada.Text_IO;

procedure Test_chaine is 

    procedure Test_Initialiser is
        C : P_string;
    begin
        Initialiser_chaine(C);
    end Test_Initialiser;
    
    procedure Test_vide is
        C : P_string;
        T : Boolean;
    begin
        Initialiser_chaine(C);
        T := Vide_chaine(C);
        pragma Assert(T=True);
    end Test_vide;
    
    procedure Test_ajout is
        chain : P_string;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'l');
        Ajout_caract(chain,'m');
        pragma Assert (Get_prem_caract(chain) = 'l');
    end Test_ajout;
    
    procedure Test_supprimer is
        chain : P_string;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'l');
        Ajout_caract(chain,'m');
        Supprimer_caract(chain);
        pragma Assert(Get_prem_caract(chain) = 'l');
        Supprimer_caract(chain);
 
    end Test_supprimer;
    
    procedure Test_supprim_prem is
        chain : P_string;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'l');
        Ajout_caract(chain,'m');
        Supprimer_prem_carac(chain);
        pragma Assert(Get_prem_caract(chain) = 'm');
    end Test_supprim_prem;
    
    procedure Test_get_prem is
        chain : P_string;
        x,y : Character;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'l');
        Ajout_caract(chain,'m');
        x := Get_prem_caract(chain);
        y := Get_prem_caract(chain);
        pragma Assert(x='l');
        pragma Assert(y = 'm');
    end Test_get_prem;
    
    procedure Test_supprim_chaine is
        chain : P_string;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'l');
        Ajout_caract(chain,'m');
        Supprimer_chaine(chain);

    end Test_supprim_chaine;
    
    procedure Test_recup_binaire is
        chain : P_string;
        binaire : t_bit;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'0');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'0');
        binaire := Recup_binaire(chain);
        pragma Assert(binaire = 0);
        binaire := Recup_binaire(chain);
        pragma Assert(binaire = 1);
        
    end Test_recup_binaire;
    
    procedure Test_afficher is
        chain : P_string;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'0');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'0');
        Afficher_chaine(chain);
    end Test_afficher;
    
    procedure Test_taille is
        chain : P_string;
        n : Integer;
    begin
        Initialiser_chaine(chain);
        Ajout_caract(chain,'0');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'1');
        Ajout_caract(chain,'0');
        n := Taille_liste(chain);
        pragma Assert(n = 4);
    end Test_taille;
    
begin
    Test_Initialiser;
    Test_vide;
    Test_ajout;
    Test_supprimer;
    Test_supprim_prem;
    Test_get_prem;
    Test_supprim_chaine;
    Test_recup_binaire;
    Test_afficher;
    Test_taille;
end Test_chaine;
