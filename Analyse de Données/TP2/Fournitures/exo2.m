load SG1.mat
load ImSG1.mat

x = Data(:);
y = DataMod(:);

% Moindres carrés linéaires
n = length(x);
B = log(y);
A = [-x,ones(n,1)];
X = pinv(A)*B;
Im = (X(2) - log(ImMod))/X(1);

%Affichage de l'image reconstruite 
figure, imagesc(Im), colormap('gray')


% Calcul de l'erreur aux moindres carrés
e_carre = immse(Im, I)


% Moindres carrés totaux
[U, S, V] = svd([A B]);
X_totaux = -(1/V(end,end))*V(1:end-1,end);
Im_svd = (X_totaux(2) - log(ImMod))/X_totaux(1);

%Affichage de l'image reconstruite 
figure, imagesc(Im_svd), colormap('gray')


% Calcul de l'erreur aux moindres carrés
e_svd = immse(I, Im_svd)


