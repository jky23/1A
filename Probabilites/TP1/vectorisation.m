function [I_gauche,I_droite] = vectorisation (I)


I_gauche = I (1:end,1:end-1);
I_droite = I (1:end, 2:1:end);
I_gauche = I_gauche(:);
I_droite = I_droite (:);
