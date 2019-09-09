clear variables;close all;clc;

%% Creation de 100 individus de R2 pour montrer comment s'effectue le changement de repere via l'ACP
nb_indiv = 100;

% Creation d'un nuage de points de R2:
% On cree separement les coordonnees des abscisses et des ordonnees, afin 
% d'avoir un nuage plus etendu dans une dimension que dans l'autre
X1 = randn(nb_indiv,1);
X2 = 5*randn(nb_indiv,1); 
X = [X1 X2];

% On decale le nuage de point. Puisqu'il s'agit de deux lois normales 
% centrees reduites, l'individu moyen est a peu pres nul. Il correspond 
% donc a peu pres a l'origine du repere canonique. On veut pouvoir 
% visualiser le changement de repere, donc on decale le nuage de points
X = X + 5*ones(nb_indiv,2);

% on va faire "tourner" le nuage, pour que les axes de la base trouvee via
% l'ACP ne soient pas confondus avec ceux de la base canonique.
angle = pi/6; 
R = [cos(angle) -sin(angle); sin(angle) cos(angle)]; 
X = X*R; 

%  On affiche le nuage de points dans le repere canonique
figure(1), axis equal, % axis equal : permet d'avoir la meme taille
% des axes pour les abscisses et les ordonnees.
p1 = plot(X(:,1),X(:,2),'r+',0, 0,'mo',...
    [0 5],[0 0],'k--',...
    [0 0],[0 5],'b--','linewidth',2);grid on;% stocker le graphe dans p1 
% permet de generer simplement une legende prenant en compte tous les 
% affichages de la figure

% l'ACP correspond a un changement de repere de l'espace des donnees : le 
% centre du repere devient l'individu moyen, les vecteurs de la base 
% maximisent la dispersion et ne sont pas correles

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT
% (cf - TP1 RVB)
x_mean = mean(X);
Xc = X - x_mean;
n = size(Xc,1);
Sigma = (Xc'*Xc)/n;
[V,D] = eig(Sigma);
[~,ind] = sort(diag(D),'descend');
V = V(:,ind);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LE NOUVEAU REPERE DEFINI PAR LES AXES PRINCIPAUX ET L'ELEMENT 
% MOYEN SUR LA FIGURE (1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1), hold on, axis equal % axis equal : permet d'avoir la meme taille
% des axes pour les abscisses et les ordonnees. Sans cela, il est impossible
% de voir que les deux axes principaux sont orthogonaux
p2 = plot(x_mean(1),x_mean(2),'mo',...
[x_mean(1) 5*V(1,1)+x_mean(1)], [x_mean(2) 5*V(2,1)+x_mean(2)],'c--',...
[x_mean(1) 5*V(1,2)+x_mean(1)], [x_mean(2) 5*V(2,2)+x_mean(2)],'g--','linewidth',2);grid on; % /!\ L'affichage du point (0,0) ne sert a rien ici
% a part a montrer comment creer une legende qui reunit les courbes de deux
% plots differents (cf lignes de code 58-59)
title('Changement de repere : repere canonique VS repere principal')
legend([p1;p2],'nuage de points','origine','premier axe canonique','deuxieme axe canonique',...
    'individu moyen','premier axe principal','deuxieme axe principal');



%% Creation de 100 individus de R10 pour montrer l'interet de projeter 
%  sur les composantes principales plutot que sur n'importe quel axe

% Creation d'un echantillon d'individus beaucoup plus disperse sur ses
% deux dernieres variables que sur les autres
X1 =  8*randn(nb_indiv,1);
X2 = 10*randn(nb_indiv,1);
X = randn(nb_indiv,8); 
X = [X,X1,X2];

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON X DANS CE NOUVEAU REPERE [i.e. LA 
% PROJECTION DES LIGNES DU TABLEAU CENTRE XC DANS LA NOUVELLE BASE] :
% CHAQUE COLONNE DE C CORRESPOND A CE QUE L'ON APPELLE UNE COMPOSANTE
% PRINCIPALE DE X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_mean1 = mean(X);
Xc = X - x_mean1;
m = size(Xc,1);
Sigma1 = Xc'*Xc/m;
[W,D] = eig(Sigma1);
[~,ind] = sort(diag(D),'descend');
W = W(:,ind);
C = Xc*W;
%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUR UNE MEME FIGURE, AFFICHER EN ROUGE LA PROJECTION DES INDIVIDUS DE XC
% SUR LES DEUX PREMIERS AXES DE LA BASE CANONIQUE [i.e. EN UTILISANT POUR 
% CHAQUE IND. SES COEFFICIENTS DANS LES DEUX PREMIERES COLONNES DE XC], 
% PUIS EN BLEU LA PROJECTION DE CES INDIVIDUS SUR LES DEUX PREMIERS AXES
% PRINCIPAUX [i.e. EN UTILISANT POUR CHAQUE IND. SES COEFFICIENTS DANS LES
% DEUX PREMIERES COLONNES DE C]
%

% QUESTION 3 RAPPORT :
% QUE REMARQUEZ-VOUS ? (A EXPLIQUER DANS LE RAPPORT)
% On remarque que le nuage de points est étalé suivant le premier axe
% principal qui minimise l'erreur d'approximation des points du nuage
% Le second axe principal fait une moins bonne approximation que le 1er

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
% NB : ATTENTION A BIEN AFFICHER LA PROJECTION DES INDIVIDUS DE XC (ET NON
% DE X) SUR LES DEUX PREMIERS AXES CANONIQUES. SINON LES DEUX NUAGES DE
% POINTS NE SERONT PAS CENTRES SUR LE MEME POINT ET IL SERA PLUS DUR D'EN
% TIRER DES CONSEQUENCES
%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
figure(2), clf
plot(Xc(:,1),Xc(:,2),'r*',C(:,1),C(:,2),'b*','linewidth',2);grid on
title('Projections sur axes canoniques VS axes principaux')
legend('Projection sur la base canonique','Projection sur les axes principaux')

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER L'INFORMATION -- i.e. LA PROPORTION DE CONTRASTE -- CONTENUE 
% DANS LES DEUX PREMIERES COMPOSANTES PRINCIPALES POUR L'ECHANTILLON X, VIA
% LES ELEMENTS SPECTRAUX DE LA MATRICE DE VARIANCE/COVARIANCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vp = sort(diag(D),'descend');
trace = sum(vp);
alph1 = vp(1);
alph2 = vp(2);
info_axe_1 = alph1/trace;
info_axe_2 = alph2/trace;
info_axe_3 = (alph1 + alph2) / trace;
fprintf('Pourcentage d info sur la premiere composante principale = %.3f\n',info_axe_1);
fprintf('Pourcentage d info sur la deuxieme composante principale = %.3f\n',info_axe_2);
fprintf('Pourcentage d info sur les deux premieres composantes    = %.3f\n',info_axe_3);


% Question 4
% A partir de la matrice Sigma, on recupère les valeurs propres que l'on
% classe dans l'ordre decroissant. La plus grande correspond à la premiere
% composante principale, et ainsi de suite. Et donc le rapport de chaque
% valeur propre avec la trace de la matrice Sigma nous quantifie l'info
% contenue dans la 1ere composante principale, et ceci pour toutes les
% composantes. 
% On peut voir que dans ce TP les deux premieres composantes principales
% suffisent a recuperer la quasi-totalité des informations.








