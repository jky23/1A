function theta_estime = estimation_3(x_donnees_bruitees_centrees,y_donnees_bruitees_centrees,theta_test)



B = x_donnees_bruitees_centrees * cos(theta_test);
C = y_donnees_bruitees_centrees * sin(theta_test);
A = B+C;
A = A.^2;
S = sum(A);
[~,argmin] = min(S);
theta_estime = theta_test(argmin);
