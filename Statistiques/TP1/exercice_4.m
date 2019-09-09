exercice_2;

% Tirage aleatoire uniforme de C :
nb_tirages = 10000;
m1 = mean(x_donnees_bruitees);
m2 = mean(y_donnees_bruitees);
sigma = cov(x_donnees_bruitees,y_donnees_bruitees);
R = chol(sigma);
m = [m1;m2]';
C_test = repmat(m,nb_tirages,1) + randn(nb_tirages,2)*R;

R_test = (2*R_0)*randn(nb_tirages,1);
[C_estime,R_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees,C_test,R_0,R_test);

% Affichage du cercle estime :
x_cercle_estime = C_estime(1)*ones(nb_points_cercle,1) + ...
                  R_estime*cos(theta_cercle);
y_cercle_estime = C_estime(2)*ones(nb_points_cercle,1) + ...
                  R_estime*sin(theta_cercle);
plot(x_cercle_estime([1:end 1]),y_cercle_estime([1:end 1]),'g--','LineWidth',3);
legend(' Cercle reel', ...
	' Donnees bruitees', ...
	' Cercle estime', ...
    'Cercle estime avec loi normale',...
	'Location','Best');