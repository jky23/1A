clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 0.4e+03;

% Tirage aleatoire d'une image de test :

Mat_conf = zeros(37,37);
for a = 1 : 100 % Boucle pour avoir une matrice de confusion

%     Pour avoir le taux de réussite quand les images de test sont connues
%     dans la base d'apprentissage
%     ni = randi(nb_individus);
%     np = randi(nb_postures);
%     individu = numeros_individus(ni);
%     posture = numeros_postures(np);
    individu = randi(37);
    posture = randi(6);
    
    LabelApr = zeros(nb_individus,nb_postures);
    ListeClasse = zeros(1,nb_individus);
    
    for i = 1:nb_individus
        for j = 1:nb_postures
            LabelApr(i,j) = numeros_individus(i);
        end
    end
    
    chemin = './Images_Projet_2019';
    fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
    Im=importdata(fichier);
    I=rgb2gray(Im);
    I=im2double(I);
    image_test=I(:)';
    
    
    % Affichage de l'image de test :
    colormap gray;
    imagesc(I);
    axis image;
    axis off;
    
    % Nombre N de composantes principales a prendre en compte
    % [dans un second temps, N peut etre calcule pour atteindre le 
    % pourcentage d'information avec N valeurs propres] :
    N = 8;
    
    % N premieres composantes principales des images d'apprentissage :
    C = Xc*W;
    imapr = C(:,1:N);
    
    % N premieres composantes principales de l'image de test :
    Xc_t = image_test - individu_moyen;
    C_t = Xc_t*W;
    imtest = C_t(:,1:N);
    
    
    % Determination de l'image d'apprentissage la plus proche 
    % (plus proche voisin) :
    k = 3;
    LabelApr = LabelApr.';
    LabelApr = LabelApr(:);
   
    % Calcul des distances entre les vecteurs de test et les vecteurs 
    % d'apprentissage (voisins)
    Distance = sum((imapr - imtest).^2, 2);
    
    % On ne garde que les indices des k + proches voisins
    kppv = zeros(1,k);
    
    Dist = Distance;
    for j = 1:k
        [~, ind] = min(Dist);
        kppv(j) = ind;
        Dist(ind) = inf;
    end

    Partition = kppv;

    l = LabelApr(Partition);
    c = mod(Partition, nb_postures).';
    c(c == 0) = nb_postures;
    indx = [l c]; % matrice contenant le n° d'indiv et de posture des k plus proches voisins

    individu_reconnu = mode(l); % le n° de l'indiv reconnu est celui dont la classe est la plus présente
    Mat_conf(individu,individu_reconnu) = Mat_conf(individu,individu_reconnu) + 1;

end

% Affichage du dernier resultat des 100 itérations pour afficher un exemple
if min(Distance) < s
    title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
        ['Je reconnais l''individu numero ' num2str(individu_reconnu)]},'FontSize',20);
else
    title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
        'Je ne reconnais pas cet individu !'},'FontSize',20);
end

% Affichage de l'image requête et des k plus proches voisins
figure('Name',"Résultat d'une requête sur une base de visages",'Position',[0.2*L,0.2*H,0.6*L,0.5*H]);
subplot(1,k+1,1);
colormap gray;
imagesc(I);
axis image;
title("Requête");

for i = 1:k
    subplot(1,k+1,i+1);
    fichier = [chemin '/' num2str(indx(i,1)+3) '-' num2str(indx(i,2)) '.jpg']
    Im=importdata(fichier);
    I=rgb2gray(Im);
    I=im2double(I);
    imagesc(I);    
    axis image;
    title("Trouvée - choix " + i);
end