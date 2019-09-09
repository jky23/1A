function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)

n = size(rho,1);
critere_min = inf;
for k=1 : parametres(3)
    M = randi(n,2,1);
    while M(1) == M(2)
         M = randi(n,2,1);
    end
    [rho_F,theta_F] = estimation_foyer(rho(M),theta(M));
    
    d = abs( rho - rho_F* cos(theta - theta_F));
    
    donnees = find(d< parametres(1));
    
    if length(donnees)/n > parametres(2)
        [rho_test,theta_test,critere] = estimation_foyer(rho(donnees), theta(donnees));
        
        if critere < critere_min
            critere_min = critere;
            rho_F_1 = rho_test;
            theta_F_1 = theta_test;
        end
    end
end

        



    