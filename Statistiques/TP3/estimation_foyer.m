function [rho_F,theta_F,critere] = estimation_foyer(rho,theta)

n = size(rho,1);

A = zeros(n,2);
A(:,1) = cos(theta);
A(:,2) = sin(theta);
B = rho;
X = pinv(A)*B;
rho_F = sqrt(X(1)^2 + X(2)^2);
theta_F = atan(X(2)/X(1));


critere = mean(abs(rho - rho_F*cos(theta - theta_F)));


