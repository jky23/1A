%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA,DataT,labelA,K,ListeClass)

[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = Nt; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    Dist = sum((DataA - DataT(i,:)).^2, 2);
    
    % On ne garde que les indices des K + proches voisins
    kppv1 = zeros(1,K);
    for k = 1:K
       [~, ind] = min(Dist);
       kppv1(k) = ind;
       Dist(ind) = inf;
    end
    
    Partition = kppv1;
    
%     % Comptage du nombre de voisins appartenant à chaque classe
%     class = zeros(1,length(ListeClass));
%     label = labelA(kppv1);
%     for j = 1:length(ListeClass)-1
%         class(j) = sum(label == j);
%     end
%    % class(10) = sum(label == 0);
% 
%     
%     % Recherche de la classe contenant le maximum de voisins
%     [nb, classe] = max(class);
%     
%     % Si l'image test a le plus grand nombre de voisins dans plusieurs  
%     % classes différentes, alors on lui assigne celle du voisin le + proche,
%     % sinon on lui assigne l'unique classe contenant le plus de voisins 
%     if sum(class == nb) > 1
%        classe = labelA(kppv1(1)); 
%     end
%     
%     % Assignation de l'étiquette correspondant à la classe trouvée au point 
%     % correspondant à la i-ème image test dans le vecteur "Partition" 
%     Partition(i) = classe;
%     if Partition(i) == 10
%         Partition(i) = 0;
%     end
%     
    

end

