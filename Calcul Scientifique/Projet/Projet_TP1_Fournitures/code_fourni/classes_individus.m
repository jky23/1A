clear variables
close all;
clc;


% chargement du jeu de donn�es
load('dataset.mat')

%% Utilisation de l'ACP pour detecter deux classes

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X, ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_mean = mean(X);
Xc = X - x_mean;
m = size(Xc,1);

Sigma = (Xc'*Xc)/m;
[W,D] = eig(Sigma);
[vp,ind] = sort(diag(D),'descend');
W = W(:,ind);
C = Xc*W;

trace = sum(vp);
info = 0;
i = 1;
while (info < 0.9)
    info = info + (vp(i)/trace);
    i = i+1;
end
nb_composantes = i -1;

plot3(C(:,1),C(:,2),C(:,3),'b*','linewidth',3)
title("Visualisation des clusters")  
 %z = kmeans(X,6);
 