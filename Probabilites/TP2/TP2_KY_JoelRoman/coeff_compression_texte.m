function coeff_compression = coeff_compression_texte(texte,texte_encode)

n = length (texte);
n = n*8;
coeff_compression = n/ length(texte_encode);