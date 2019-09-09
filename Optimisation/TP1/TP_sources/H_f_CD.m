%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H=H_f_CD(beta)
% Calcul de la matrice Hessienne de la fonction f_CD
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

global Ki Li Yi
r = res_CD(beta);
Jres = J_res_CD(beta);
H = transpose(Jres) * Jres;
H(1,2) = H(1,2) + transpose(r) * (log(Li./Ki) .* (Ki.^(beta(2))) .* (Li.^(1-beta(2))));
H(2,1) = H(1,2);
H(2,2) = H(2,2) - transpose(r) * (beta(1) .* (log(Li./Ki).^2) .* (Ki.^(beta(2))) .* (Li.^(1-beta(2))));



%TO DO

end
