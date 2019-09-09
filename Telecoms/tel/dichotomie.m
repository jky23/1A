function [dans,indice] = dichotomie(x,X)

    for i=1:length(X)
        if (x==X(i))
            dans = 1;
            indice = i;
            return
        end
    end
    dans = 0;
    indice = -1;
end