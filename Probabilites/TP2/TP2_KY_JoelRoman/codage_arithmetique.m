function [borne_inf,borne_sup] = codage_arithmetique(texte,selection_alphabet,bornes)

n = length(texte);
borne_inf = 0;
borne_sup = 1;
for i = 1 : n
    c = find(selection_alphabet == texte(i));
    largeur = borne_sup - borne_inf;
    borne_sup = borne_inf+(largeur*bornes(2,c));
    borne_inf = borne_inf+(largeur*bornes(1,c));
end


    
    
    