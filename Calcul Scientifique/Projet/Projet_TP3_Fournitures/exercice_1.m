clear;
close all;
load ('donnees.mat');

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
load donnees;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

% Calcul de l'individu moyen :
individu_moyen = mean(X);

% Centrage des donnees :
Xc = X - individu_moyen;

% Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
m = size(Xc, 1);
Sigma_2 = (Xc * Xc')/n;

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
time = cputime;
[W,D] = eig(Sigma_2);
time = cputime -time

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[vp,ind] = sort(diag(D),'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
W = W(:,ind);

% Elimination du dernier vecteur propre de Sigma_2 :
W = W(:,1:end-1);

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = Xc'*W;
    
% Normalisation des vecteurs propres de Sigma
% [les vecteurs propres de Sigma_2 sont normalis??s
% mais le calcul qui donne W, les vecteurs propres de Sigma,
% leur fait perdre cette propri??t??] :
for k =1: n-1
    W(:,k) = W(:,k)/norm(W(:,k));
end


% Affichage de l'individu moyen et des eigenfaces sous forme d'images :
colormap gray;
img = reshape(individu_moyen,nb_lignes,nb_colonnes);
subplot(nb_individus,nb_postures,1);
imagesc(img);
axis image;
axis off;
title('Individu moyen','FontSize',15);
for k = 1:n-1
	img = reshape(W(:,k),nb_lignes,nb_colonnes);
	subplot(nb_individus,nb_postures,k+1);
	imagesc(img);
	axis image;
	axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
end
% 
 save exercice_1;
