function X_chapeau = MCO(x, y)

n = size(x,1);
A0 = [x.^2, x.*y, y.^2, x, y, ones(n,1)];
A1 = [1,0,1,0,0,0];
A = [A0;A1];

B0 = zeros(n,1);
B = [B0;1];
X_chapeau = pinv(A)*B;

