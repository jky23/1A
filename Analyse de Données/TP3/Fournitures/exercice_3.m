%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% exercice_3.m
%--------------------------------------------------------------------------

clear
close all
clc

% Chargement des données de l'exercice 2
load resultats_ex2

%% Classifieur par maximum de vraisemblance
% code_classe est la matrice contenant des 1 pour les chrysanthemes
%                                          2 pour les oeillets
%                                          3 pour les pensees
% l'attribution de 1,2 ou 3 correspond au maximum des trois vraisemblances


V_max = max(V_oeillets, V_pensees);
V_max = max(V_max, V_chrysanthemes);
code_classe=zeros(nb_r,nb_v);
classe_pensees=find(V_max == V_pensees);
classe_oei=find(V_max == V_oeillets);
classe_chrys=find(V_max == V_chrysanthemes);
code_classe(classe_pensees)=3;
code_classe(classe_oei)=2;
code_classe(classe_chrys)=1;









%% Affichage des classes

figure('Name','Classification par maximum de vraisemblance',...
       'Position',[0.25*L,0.1*H,0.5*L,0.8*H])
axis equal ij
axis([r(1) r(end) v(1) v(end)]);
hold on
imagesc(r,v,code_classe)
carte_couleurs = [.45 .45 .65 ; .45 .65 .45 ; .65 .45 .45];
colormap(carte_couleurs)
hx = xlabel('$\overline{r}$','FontSize',20);
set(hx,'Interpreter','Latex')
hy = ylabel('$\bar{v}$','FontSize',20);
set(hy,'Interpreter','Latex')
view(-90,90)

%% Comptage des images correctement classees

f_pensees = densite(mu_pensees, Sigma_pensees, X_pensees);
f_oeillets = densite(mu_oeillets, Sigma_oeillets, X_oeillets);
f_chrysanthemes = densite(mu_chrysanthemes, Sigma_chrysanthemes, X_chrysanthemes);


