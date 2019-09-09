function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)

E_x = E_nouveau_repere(:,1);
E_y = E_nouveau_repere(:,2);

n = length(E_x);
x_min = min(E_x);
x_max = max(E_x);
y_min = min(E_y);
y_max = max(E_y);
N = (x_max-x_min)*(y_max-y_min);
bin = binocdf(n-1,floor(N),p);

probabilite = 1-bin;