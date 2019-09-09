function f = densite(mu, Sigma,X)

n = size(X,1);
Xc = X - repmat(mu',n,1);
f = exp(Xc'.*Sigma.*Xc);
f = f/((2*pi)^(n) * sqrt(det(Sigma)));