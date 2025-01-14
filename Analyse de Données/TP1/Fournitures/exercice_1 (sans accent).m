%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP1 - Espace de representation des couleurs
% Exercice_1.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Decompostion des canaux RVB d'une image couleur

%I = imread('autumn.tif');          % 1er exemple
I = imread('gantrycrane.png');     % 2nd exemple

% Decoupage de l'image en trois canaux et conversion en flottants
R = single(I(:,:,1));
V = single(I(:,:,2));
B = single(I(:,:,3));

%% Affichage de l'image RVB et de ses canaux

% 1ere fenetre d'affichage
figure('Name','Separation des canaux RVB',...
       'Position',[0.01*L,0.1*H,0.59*L,0.75*H])

% Affichage de l'image RVB
    subplot(2,2,1)	% La fenetre comporte 2 lignes et 2 colonnes
    imagesc(I)
    axis off image
    title('Image RVB','FontSize',20)
    
colormap gray % Pour afficher les images en niveaux de gris
              % Affichage avec la palette 'parula' par defaut sinon
    
% Affichage du canal R
    subplot(2,2,2) % 1ere ligne, 2nde colonne
    imagesc(R)
    axis off image
    title('Canal R','FontSize',20)
    
% Affichage du canal V
    subplot(2,2,3) % 2nde ligne, 1ere colonne
    imagesc(V)
    axis off image
    title('Canal V','FontSize',20)
    
% Affichage du canal B
    subplot(2,2,4) % 2nde ligne, 2nde colonne
    imagesc(B)
    axis off image
    title('Canal B','FontSize',20)
    
% Enregistrement des images des canaux
imwrite(uint8(R),'canal_R.png')
imwrite(uint8(V),'canal_V.png')
imwrite(uint8(B),'canal_B.png')

%% Affichage du nuage de pixels dans le repere RVB

% Deuxieme fenetre d'affichage
figure('Name','Nuage de pixels dans le repere RVB',...
       'Position',[0.61*L,0.1*H,0.38*L,0.6*H])

    plot3(R,V,B,'b.')
    axis equal
    grid on
    xlabel('R','FontWeight','bold')
    ylabel('V','FontWeight','bold')
    zlabel('B','FontWeight','bold')
    title({'Representation 3D des pixels' ...
           'dans l''espace RVB'},'FontSize',20)
    rotate3d 

%% Calcul des correlations entre les canaux RVB et des contrastes
    
% Matrice des donnees
X = [R(:) V(:) B(:)];	% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance
% A REMPLIR %

% Coefficients de correlation lineaire
% A REMPLIR %

% Proportions de contraste
% A REMPLIR %

