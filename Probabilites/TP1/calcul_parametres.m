function [r,a,b] = calcul_parametres (X,Y)

moyenne_x = mean (X);
moyenne_y = mean (Y);
variance_x = mean ( X.^2 -(moyenne_x)^2);
variance_y = mean ( Y.^2 -(moyenne_y)^2);
ecart_x = sqrt ( variance_x);
ecart_y = sqrt ( variance_y);
covariance = (mean (X.*Y) - (moyenne_x * moyenne_y));
r = covariance / ( ecart_x * ecart_y) ; 
a = covariance / (ecart_x)^2 ;
b = moyenne_y - (a*moyenne_x);


