function [Y,Yunique] = rle(X) % X vecteur 1D

    [imax,~] = size(X);
    Y = [];
    Yunique = [];
    i = 1;
    
    while i < imax
        count = 1;
        while (i<imax && X(i) == X(i+1))
            count = count + 1;
            i = i + 1;
        end
        Y = [Y ; X(i) count];
        if (length(Yunique) < 1)
            Yunique = [Yunique ; X(i) count];
        else
            [dans,indice] = dichotomie(X(i),Yunique(:,1));
            if (dans)
                Yunique(indice,2) = Yunique(indice,2) + 1;
            else
                Yunique = [Yunique ; X(i) count];
            end
        end
        i = i + 1;
    end
    if (i == imax)
        Y = [Y ; X(imax) 1];
    end
end