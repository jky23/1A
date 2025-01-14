clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Fenetre d'affichage :
figure('Name','Donnees situees au voisinage d''un cercle', ...
       'Position',[0.2*L,0,0.6*L,0.8*H]);
axis equal;
hold on;
set(gca,'FontSize',20);
hx = xlabel('$x$','FontSize',30);
set(hx,'Interpreter','Latex');
hy = ylabel('$y$','FontSize',30);
set(hy,'Interpreter','Latex');

% Parametres :
taille = 20;
echelle = [-taille taille -taille taille];

% Parametres du cercle reel :
R_0 = 10;
C = (taille-R_0)*(2*rand(1,2)-1);
theta = 2*pi*rand(2,1);
% Affichage du cercle :
nb_points_cercle = 100;
theta_cercle = transpose(2*pi/nb_points_cercle:2*pi/nb_points_cercle:2*pi);

x_cercle_reel = C(1) + R_0*cos(theta_cercle);
y_cercle_reel = C(2) + R_0*sin(theta_cercle);

plot(x_cercle_reel([1:end 1]),y_cercle_reel([1:end 1]),'r','LineWidth',3);

% Donnees bruitees :
n = 50;
sigma = 0.5;
%rho_donnees_bruitees = R_0 + sigma*randn(n,1);
theta_donnees_bruitees = 2*pi*rand(n,1);
if theta(1) <= theta(2)
    theta_donnees_bruitees = theta_donnees_bruitees(theta_donnees_bruitees >= theta(1) & theta_donnees_bruitees <= theta(2));
    m = length(theta_donnees_bruitees);
    rho_donnees_bruitees = R_0 + sigma*randn(m,1);
    x_donnees_bruitees = C(1) + rho_donnees_bruitees.*cos(theta_donnees_bruitees);
    y_donnees_bruitees = C(2) + rho_donnees_bruitees.*sin(theta_donnees_bruitees);
else
    theta_donnees_bruitees = theta_donnees_bruitees(theta_donnees_bruitees<= theta(2) | theta_donnees_bruitees >= theta(1));
    m = length(theta_donnees_bruitees);
    rho_donnees_bruitees = R_0 + sigma*randn(m,1);
    x_donnees_bruitees = C(1) + rho_donnees_bruitees.*cos(theta_donnees_bruitees);
    y_donnees_bruitees = C(2) + rho_donnees_bruitees.*sin(theta_donnees_bruitees);
end
% Affichage des donnees bruitees :
plot(x_donnees_bruitees,y_donnees_bruitees,'k+','MarkerSize',10,'LineWidth',2);
axis(echelle);
legend(' Cercle reel', ...
	' Donnees bruitees', ...
	'Location','Best');
grid on;
