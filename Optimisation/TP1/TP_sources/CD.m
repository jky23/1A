%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient le programme principal permettant l'estimation    %
% des parametres de la fonction de Cobb-Douglas par une approche     %
% des moindres carres.						        %
% Modele :Y(K,L)=A*K^(alpha)*L^(1-alpha)					        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; format short
% Initialisation

% Donn�es 
global Ki Li Yi

Ki=[0.14;0.71;0.28; 0.64; 0.02; 0.81; 0.36; 0.49; 0.94; 0.58];
Li=[0.39; 0.18; 0.14; 0.95; 0.31; 0.72; 0.59; 0.81; 0.45; 0.63];
Yi=[0.12; 0.27;0.14; 0.45; 0.01; 0.48; 0.24; 0.36; 0.43; 0.37];

%Estimation a priori des parametres du modele.
% beta0=[A;alpha];
beta0=[0.35;0.2];

%%%%%%% Figure 1 %%%%%%%%
% Affichage des donnees
figure(1)                         
rect=[0 1 0 1 0 1];
axis(rect)
xlabel('K')
ylabel('L')
zlabel('Y')
plot3(Ki,Li,Yi,'or')
hold on

% Affichage de la prevision du modele.
beta=beta0

xmin=0;
xmax=1;
nx=100;
pasx=(xmax-xmin)/nx;
ymin=0;
% ymin=-0.0001;
ymax=1;
ny=100;
pasy=(ymax-ymin)/ny;
x=xmin:pasx:xmax;
y=ymin:pasy:ymax;
[X,Y]=meshgrid(x,y);
[m,n]=size(X);
for i=1:m,
   for j=1:n,
      Z(i,j)=beta(1)*X(i,j)^beta(2)*Y(i,j)^(1-beta(2));
   end;
end;
contourf(X,Y,Z,150);

%%%%%%% Figure 4 %%%%%%%%
% Methode de Gauss-Newton

%Evaluation de la fonction des moindres carres 
for i=1:m,
   for j=1:n,
      Z(i,j)=f_CD([X(i,j),Y(i,j)]);
   end;
end;

% Affichage des lignes de niveau de la fonction des moindres carres.
figure(4)                            
contour(X,Y,Z,250);
xlabel('A')
ylabel('alpha')
hold on
text(beta(1),beta(2),'o point de depart')


%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%
% 1- Minimisation de la fonction des moindres carres par la m�thode de Gauss-Newton

%Initialisations
beta = beta0;
iter =0;
C1 = 1e-12;
C2 = 1e-12;
iter_max = 100;
gf = grad_f_CD(beta0);
seuil_G = max(C1 * norm(gf),sqrt(eps));
stop = 0;
while (stop == 0)
    iter = iter + 1;
    J = J_res_CD(beta);    
    beta_n = beta - ((transpose(J)*J) \ gf);
    gf = grad_f_CD(beta_n);
    if (iter>iter_max) |  (norm(gf) < seuil_G) | (norm(beta_n - beta) < max(C2*norm(beta), sqrt(eps)))
        stop = 1;
    end
    beta = beta_n;
    
    text(beta(1),beta(2),['0 iter' ,num2str(iter)]);


end

% 2- Affichage des la prevision du modele et de l'estimation des parametres
% au cours de la minimisation


%%%%%%%%%% END TO DO  %%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Methode de Newton %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimation a priori des parametres du modele.
beta=beta0

%%%%%%% Figure 5 %%%%%%%%
% Methode Newton

figure(5)                          
contour(X,Y,Z,250);
xlabel('A')
ylabel('alpha')
hold on
text(beta(1),beta(2),'o point de depart')

%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%
% 1- Minimisation de la fonction des moindres carres par la m�thode de Newton
beta = beta0;
iter =0;
C1 = 1e-12;
C2 = 1e-12;
iter_max = 100;
gf = grad_f_CD(beta0);
seuil_G = max(C1 * norm(gf),sqrt(eps));
stop = 0;
while (stop == 0)
    iter = iter + 1;
    beta_n = beta - (H_f_CD(beta) \ gf);
    gf = grad_f_CD(beta_n);
    if iter>iter_max |  norm(gf) < seuil_G | norm(beta_n - beta) < max(C2*norm(beta), sqrt(eps))
        stop = 1;
    end
    beta = beta_n;
    text(beta(1),beta(2),['0 iter' ,num2str(iter)]);

end

% 2- Affichage des la prevision du modele et de l'estimation des parametres
% au cours de la minimisation



%%%%%%%%%% END TO DO  %%%%%%%%%%%%%
