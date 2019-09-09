function [a_estime,b_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees)

n = size(x_donnees_bruitees,1);
A = ones(n,2);
A(:,1) = x_donnees_bruitees;


B = y_donnees_bruitees;

X = pinv(A)*B;
a_estime = X(1);
b_estime = X(2);