%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt classique
    %------------------------------------------------
   for j = 1 : m 
       u = 0;
       for k = 1 : j-1
           u =  u + (transpose(Q(:,k)) * A(:,j)) * Q(:,k); % Calcul dela composante de A suivant les colonnes de Q
       end 
       y = A(:,j) - u; % retrnacher la composante
       y = y / norm(y); % normaliser
       Q(:,j) = y; %restituer la colonne de Q
   end
       
            
        

end