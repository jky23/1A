function psi_estime = estimation_1(x_donnees_bruitees_centrees,y_donnees_bruitees_centrees,psi_test)

n = size(psi_test,2);

B = x_donnees_bruitees_centrees * (tan(psi_test));
C = y_donnees_bruitees_centrees * ones(1,n);
A = C - B;
A = A.^2;
S = sum(A);
[~,argmin] = min(S);
psi_estime = psi_test(argmin);
