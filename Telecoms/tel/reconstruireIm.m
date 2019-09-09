function I = reconstruireIm(X) % X nx8x8
I = zeros(size(X,1)/8,size(X,2)/8);

for r = 1:sqrt(size(X,1))
    for k=r:sqrt(size(X,1))*r
        for i=1:8
            for j=1:8
                I(i+8*(r-1),j+mod((k-1),sqrt(size(X,1)))*8) = X(k,i,j);
            end
        end
    end
end

end