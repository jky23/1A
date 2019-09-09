function C_estime = estimation_1(x_donnees_bruitees,y_donnees_bruitees,C_test,R_0)

n = size(C_test,1);
M = zeros(n,1);

for i = 1 : n
    di = sqrt(((x_donnees_bruitees - C_test(i,1)).^2) + ((y_donnees_bruitees - C_test(i,2)).^2));
    ei = (di- R_0).^2;
    M(i,1) = sum(ei);
end
[~,argmin] = min(M);
C_estime = C_test(argmin,:);
    