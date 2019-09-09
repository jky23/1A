f0 = 100;
Fe = 10000;
T0 = 1/f0;
Te = 1/Fe;
N = 1000;
A = 1;
SNR = 10;

%Generation de la fonction cosinus

x=(1:N)/Fe;
y1 = A*cos(2*pi*f0*x);
Ps = mean(abs(y1).^2);
Pb = Ps * 10^(-SNR/10);

%Bruit a ajouter

y2 = sqrt(Pb)*randn(1,N);
z = y1 + y2;

%Trace du signal bruité
figure
plot(x,z,'b')
xlabel("Temps en (s)");
ylabel("Signal");
title('Signal bruité')
