%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% Mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r=res_CD(beta)
% Calcul du vecteur des residus
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

global Ki Li Yi

% TO DO
r = Yi - beta(1) * (Li.^(1-beta(2))) .* (Ki.^(beta(2)));



end
