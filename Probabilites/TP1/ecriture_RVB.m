function image_RVB = ecriture_RVB ( image_originale)
[nb_lignes, nb_colonnes]= size (image_originale);
nb_l = nb_lignes / 2 ;
nb_c = nb_colonnes/2;
image_RVB = zeros (nb_l,nb_c,3);
image_RVB (:,:,1) = image_originale (1:2:end,2:2:end);
image_RVB (:,:,2) = (image_originale (1:2:end,1:2:end) + image_originale(2:2:end,2:2:end))/2;
image_RVB (:,:,3) = image_originale (2:2:end,1:2:end); 


