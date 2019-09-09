function coef = coeff_compression_image (histogramme,dico)

n = sum(histogramme);
n = n*8;
m = 0;
for i = 1 : length (dico)
    m = m + (length (dico {i,2})* histogramme(i));
end
coef = n / m;

