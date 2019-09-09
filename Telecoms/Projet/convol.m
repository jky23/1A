clear all;
nb_bits = 100;
k =3;
% Generation des bits à transmettre
Bits = randi(2,1,nb_bits) - 1;

%% Codage canal

% Codage convolutif

%generation du trellis
trellis = poly2trellis(k, [5 7]);
P = [1 1 0 1];
% codage convolutif
Bits_conv = convenc(Bits, trellis, P);



% decodage de viterbi


dk = 1 - 2 *Bits_conv;


bits_decodes = vitdec(dk, trellis, 5*k, 'trunc','unquant',P);

