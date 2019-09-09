function frequences = calcul_frequences (texte,alphabet)

n1 = length(alphabet);
M = zeros (n1,1);
n2 = length (texte);



for i = 1 : n1
   vect= (texte == alphabet(i));
   M (i) = sum(vect);
end

frequences = M / n2;
         
        





