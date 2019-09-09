clear variables;close all;clc;

%% Utilisation de l'ACP pour detecter deux classes

% Creation d'un echantillon contenant deux classes que nous allons
% retrouver via l'ACP
nb_indiv1 = 100;nb_indiv2 = 150;nb_indiv = nb_indiv1+nb_indiv2; 
nb_param = 30;
% Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = randn(nb_indiv1,nb_param);X1 = X1 - 0.5*ones(nb_indiv1,1)*ones(1,nb_param);  
% Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = randn(nb_indiv2,nb_param);X2 = X2 + 1*ones(nb_indiv2,1)*ones(1,nb_param); 
% Creation du tableau des donnees (concatenation des deux classes) 
X = [X1;X2]; 

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
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
[~,ind] = sort(diag(D),'descend');
W = W(:,ind);
C = Xc*W;

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DES INDIVIDUS DE XC SUR LE PREMIER AXE DU REPERE 
% CANONIQUE. LES INDIVIDUS DES DEUX CLASSES DOIVENT ETRE REPRESENTES PAR 
% DEUX COULEURS DIFFERENTES.
% AFFICHER LA PROJECTION DE CES MEMES INDIVIDUS SUR LE PREMIER AXE 
% PRINCIPAL (AVEC A NOUVEAU UNE COULEUR PAR CLASSE).
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1), clf, 
subplot(2,1,1)
plot(0,0,'ko','linewidth',2)
hold on,plot([min(Xc(:,1))-1  max(Xc(:,2))+1],[0 0],'k-')
hold on,plot(Xc(1:nb_indiv1,1),zeros(1,nb_indiv1), 'r*','linewidth',3)
hold on, plot(Xc(nb_indiv1 + 1:end ,1), zeros(1,nb_indiv2), 'b*','linewidth',3)
legend('Origine','Droite','Individus de la 1ere classe', 'Individus de la 2e classe')
% Affichage des donnees sur la premiere composante canonique :
% les individus de la premiere classe sont en rouge (p. ex), ceux de la 
% seconde classe sont en bleu
title('Visualisation des donnees sur le premier axe canoniques')

% Affichage des donnees sur la premiere composante principale : (m�me
% code couleur)
subplot(2,1,2)
plot(0,0,'ko','linewidth',2)
hold on,plot([min(C(:,1))-1 max(C(:,2))+1],[0 0],'k-')
hold on,
plot(C(1:nb_indiv1,1),zeros(1,nb_indiv1), 'r*','linewidth',3)
hold on, plot(C(nb_indiv1 + 1:end ,1),zeros(1,nb_indiv2), 'b*','linewidth',3);
legend('Origine','Droite','Individus de la 1ere classe', 'Individus de la 2e classe')
title('Visualisation des donnees sur le premier axe principal');

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vp = sort(diag(D),'descend');
trace = sum(vp);
info = vp./trace;
figure(2), clf
plot(info,'b--o')
title('Pourcentage d info contenue sur chaque composante ppale -- 2 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

%% Utilisation de l'ACP pour detecter plusieurs classes

% Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees 
% d'individus vivant dans le meme espace. Chacun de ces tableaux 
% represente une classe. On concatene ces tableaux en un unique tableau X, 
% et on va chercher combien de composantes principales il faut prendre en 
% compte afin de detecter toutes les classes
load('quatre_classes.mat')
n1 = size(X1,1);n2 = size(X2,1);n3 = size(X3,1);n4 = size(X4,1);
n = n1+n2+n3+n4;
X = [X1;X2;X3;X4];
nb_param = size(X,2);

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_mean = mean(X);
Xc = X - x_mean;
m = size(Xc,1);

Sigma = (Xc'*Xc)/m;
[W,D] = eig(Sigma);
[~,ind] = sort(diag(D),'descend');
W = W(:,ind);
C = Xc*W;
disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DE XC SUR :
% - LE PREMIER AXE PRINCIPAL
% - LE DEUXIEME AXE PRINCIPAL
% - LE TROISIEME AXE PRINCIPAL
% EN UTILISANT UNE COULEUR PAR CLASSE.
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES EST-ON CAPABLE DE DETECTER AVEC LA PREMIERE 
% COMPOSANTE, LA DEUXIEME, LA TROISIEME, PUIS LES TROIS ENSEMBLES ?
% NB : VOTRE FIGURE DOIT CORRESPONDRE A LA FIGURE 2(b) DE L'ENONCE.
% 
% Grace à chaque composante, on est capable de différencier deux classes
% de données. A l'issue de l'analyse des 3 composante, on est donc capable
% de différencier toutes les calsses de données réelles.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3),clf
subplot(3,1,1)
plot(0,0,'ko','linewidth',2)
hold on,plot([min(C(:,1))-1 max(C(:,1))+1],[0 0],'k-')
hold on,
plot(C(1:n1,1),zeros(1,n1), 'r*','linewidth',3)
hold on, plot(C(n1 + 1: n1+n2 ,1),zeros(1,n2), 'b*','linewidth',3)
hold on, plot(C(n1+n2+1: n1+n2+n3,1),zeros(1,n3), 'g*','linewidth',3)
hold on, plot(C(n1+n2+n3+1:end,1),zeros(1,n4), 'y*','linewidth',3)
legend('Origine','Droite','1ere classe', '2e classe', '3e classe', '4e classe')
title('1ere composante ppale')

subplot(3,1,2)
plot(0,0,'ko','linewidth',2)
hold on,plot([min(C(:,2))-1 max(C(:,2))+1],[0 0],'k-')
hold on,
plot(C(1:n1,2),zeros(1,n1), 'r*','linewidth',3)
hold on, plot(C(n1 + 1: n1+n2 ,2),zeros(1,n2), 'b*','linewidth',3)
hold on, plot(C(n1+n2+1: n1+n2+n3,2),zeros(1,n3), 'g*','linewidth',3)
hold on, plot(C(n1+n2+n3+1:end,2),zeros(1,n4), 'y*','linewidth',3)
legend('Origine','Droite','1ere classe', '2e classe', '3e classe', '4e classe')
title('2eme composante ppale')

subplot(3,1,3)
plot(0,0,'ko','linewidth',2)
hold on,plot([min(C(:,3))-1 max(C(:,3))+1],[0 0],'k-')
hold on,
plot(C(1:n1,3),zeros(1,n1), 'r*','linewidth',3)
hold on, plot(C(n1 + 1: n1+n2 ,3),zeros(1,n2), 'b*','linewidth',3)
hold on, plot(C(n1+n2+1: n1+n2+n3,3),zeros(1,n3), 'g*','linewidth',3)
hold on, plot(C(n1+n2+n3+1:end,3),zeros(1,n4), 'y*','linewidth',3)
legend('Origine','Droite','1ere classe', '2e classe', '3e classe', '4e classe')
title('3eme composante ppale')

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
% PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
% L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
% NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4), clf, 
plot(C(1:n1,1),C(1:n1,2), 'r*','linewidth',3)
hold on, plot(C(n1+1:n1+n2,1),C(n1 + 1: n1+n2 ,2), 'b*','linewidth',3)
hold on, plot(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1: n1+n2+n3,2), 'g*','linewidth',3)
hold on, plot(C(n1+n2+n3+1:end,1),C(n1+n2+n3+1:end,2), 'y*','linewidth',3);grid on
legend('1ere classe', '2e classe', '3e classe', '4e classe')
title('Proj. des donnees sur les deux 1ers axes ppaux')

figure(5),clf, 
plot3(C(1:n1,1),C(1:n1,2),C(1:n1,3), 'r*','linewidth',3)
hold on, plot3(C(n1+1:n1+n2,1),C(n1 + 1: n1+n2 ,2),C(n1+1:n1+n2,3), 'b*','linewidth',3)
hold on, plot3(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1: n1+n2+n3,2),C(n1+n2+1:n1+n2+n3,3), 'g*','linewidth',3)
hold on, plot3(C(n1+n2+n3+1:end,1),C(n1+n2+n3+1:end,2),C(n1+n2+n3+1:end,3), 'y*','linewidth',3);
grid on
title('Proj. des donnees sur 3 1ers axes ppaux')

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vp = sort(diag(D),'descend');
trace = sum(vp);
info1 = vp./trace;
figure(6),clf
plot(info1,'b--o')
title('Pourcentage d info contenue sur chaque composante ppale -- 4 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
% EN DEUX GROUPES.
%
% QUESTION 5 RAPPORT :
% COMMENTER.
% On remarque avec deux classes, une composante suffit a retrouver la
% majorité de l'information, tandis qu'avec 04 classes on a besoin d'aller
% jusqu'a 03 valeurs propres.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(7),clf
plot(info,'r-o'); hold on; plot(info1,'b-o')
title("Comparaison de la variation du pourcentage d'information");
xlabel('Numero de la composante');
ylabel('Pourcentage');
legend('Classification en 02','Classification en 04');
