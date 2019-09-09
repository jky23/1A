function  [C_estime, R_estime,d_min] = estimation_cercle(x_donnees_bruitees, y_donnees_bruitees,C_test,R_0,R_test)

p = size(C_test,1);
M = zeros(p,1);

for i = 1 : p
    di = sqrt(((x_donnees_bruitees - C_test(i,1)).^2) + ((y_donnees_bruitees - C_test(i,2)).^2));
    ei = (di- R_test(i,1)).^2;
    M(i) = sum(ei);
end
[d_min,argmin] = min(M);
C_estime = C_test(argmin,:);
R_estime = R_test(argmin);
