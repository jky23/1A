function [C_x,C_y,M] = matrice_inertie(E_x,E_y,E_G_norme)

pi = sum(E_G_norme);
C_x = sum(E_G_norme.*E_x);
C_y = sum(E_G_norme.*E_y);
C_x = C_x/pi;
C_y = C_y/pi;
M = zeros(2,2);
M(1,1) = sum((E_G_norme.* (E_x-C_x).^2));
M(2,2) = sum((E_G_norme.* (E_y-C_y).^2));
M(1,2) = sum((E_G_norme.* (E_x-C_x).*(E_y-C_y)));
M(1,1) = M(1,1)/pi;
M(2,2) = M(2,2)/pi;
M(1,2) = M(1,2)/pi;
M(2,1) = M(1,2);