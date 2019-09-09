function  [C_estime,R_estime] = RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)

n = size(x_donnees_bruitees,1);
critere = Inf;
for k=1 : parametres(3)
 
    M = randi(n,2,1);
    while M(1) == M(2)
         M = randi(n,2,1);
    end
    %nb_tirages = 100;
    C_test = (parametres(4)-parametres(5))*(2*rand(n,2)-1);
    R_test = (2*parametres(5))*rand(n,1);
    [C_est, R_est] = estimation_cercle(x_donnees_bruitees(M), y_donnees_bruitees(M),C_test,parametres(5),R_test);
    d = abs(sqrt((x_donnees_bruitees - C_est(1)).^2 + (y_donnees_bruitees - C_est(2)).^2) - R_est);
    donnees = find (d < parametres(1));
    if length(donnees)/n > parametres(2)
        [C_1,R_1,d_min] = estimation_cercle(x_donnees_bruitees(donnees),y_donnees_bruitees(donnees),C_test,parametres(5),R_test);
       
        if d_min < critere
            C_estime = C_1;
            R_estime = R_1;
            critere = d_min;
        end
    end
end
            