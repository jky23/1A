%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Jres=J_res_CD(beta)
% Calcul de la matrice Jacobienne du vecteur des residus
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

global Ki Li Yi

% TO DO
r = res_CD(beta);
n = size(r,1);
Jres = zeros(n,2);
Jres(:,1) = -(Ki.^beta(2)) .* (Li.^(1-beta(2)));
Jres(:,2) = beta(1) .* log(Li./Ki) .* (Ki.^(beta(2))) .* (Li.^(1-beta(2)));
end
