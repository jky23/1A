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
info = vp./trace;
figure(1), clf
plot(info(1:50)*100,'r-o')
title('Pourcentage d info contenue sur chaque composante ppale')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

% Cette figure nous permet de voir que on a besoin de 06 composantes
% principales pour l'ACP
nb_composantes = 7;
prct = sum(vp(1:nb_composantes+1))*100/trace;

disp(prct + "% de l'information est disponible avec les " + nb_composantes + " premieres composantes ")
%plot3(C(:,1),C(:,2),C(:,3),'b*','linewidth',3)
z = kmeans(C,nb_composantes);
taille = zeros(1,nb_composantes);
figure(2),clf
for k=1 : nb_composantes
    plot3(C(z==k,1),C(z==k,2),C(z==k,3),'o','linewidth',3); hold on;
end
 
figure(3),clf
for k=1 : nb_composantes
    plot3(C(z==k,4),C(z==k,5),C(z==k,6),'o','linewidth',3); hold on;   
end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 