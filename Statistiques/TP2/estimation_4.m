function [cos_theta_estime,sin_theta_estime] = estimation_4(xy_donnees_bruitees_centrees)


C = xy_donnees_bruitees_centrees;
C = transpose(C)*C;
[V,D] = eig(C);
[~,b]= min(diag(D));
Y = V(:,b);
cos_theta_estime = Y(1);
sin_theta_estime = Y(2);