function X = moyenne(I)

%On met l'image sous le format single pour ne manipuler que des reels
I = single(I);
X = [];

%On obtient les composantes rouges, vert et bleu de l'image
R = I(:,:,1);
V = I(:,:,2);
B = I(:,:,3);
somme = sum(I,3);

%On normalise ensuite l'image
r = R ./ max(1, somme);
v = V ./ max(1, somme);


%On retourne les moyennes de deux couleurs

X(1) = mean(r(:));
X(2) = mean(v(:));