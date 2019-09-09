function [mu, Sigma] = estimation_mu_Sigma(X)

n = size(X,1);
mu = transpose(X) * ones(n,1) / n;
Xc = X - repmat(mu',n,1);
Sigma = transpose(Xc) * Xc / n;