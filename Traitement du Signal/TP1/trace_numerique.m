f0 = 100;
Fe = 10000;
T0 = 1/f0;
Te = 1/Fe;
N = 1000;
A = 1;

%Generation de la fonction cosinus
x= (1:N)/Fe;
y = A*cos(2*pi*f0*x);

%Trace du signal
figure;

plot(x,y,'b--o')
xlabel("Temps en secondes");
ylabel("Signal");
title("Signal numerique");