%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% mgs.m
%--------------------------------------------------------------------------

function Q = mgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt modifie
    %------------------------------------------------
     for j = 1 : m
        y = A(:,j);
        for k = 1 : j-1 
            u = (transpose(Q(:,k)) * y) * Q(:,k) ;  % Calcul de la composante
            y = y - u; % retrancher a y la composante
        end
        y = y / norm(y) ; % normaliser y
        Q(:,j) = y; %restituer la nouvelle colonne de Q
     end
            

end