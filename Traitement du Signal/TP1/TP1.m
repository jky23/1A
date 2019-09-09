f0 = 100;
Fe = 10000;
T0 = 1/f0;
Te = 1/Fe;
N = 1000;
A = 1;
SNR = 10;


%% Génération du signal numérique
x1 = Te*(1:N);
y1 = A*cos(2*pi*f0*x1);


%Trace du signal
figure;

plot(x1,y1,'b--o')
xlabel("Temps en secondes");
ylabel("Signal");
title("Signal numerique");


%% Bruit numérique

x = sigma*randn(1,N);
figure;
plot(x,'r')
xlabel('t en secondes')
ylabel('dB')
title('Tracé du bruit')


%% Generation du signal numérique bruité
%Bruit a ajouter
Ps = mean(abs(y1).^2);
Pb = Ps * 10^(-SNR/10);
y2 = sqrt(Pb)*randn(1,N);
z = y1 + y2;

%Trace du signal bruité
figure;
plot(x1,z,'b')
xlabel("Temps en (s)");
ylabel("Signal");
title('Signal bruité')


%% Estimation de la fonction d'auto-correlation
%Generation de la fonction cosinus

x1 = Te*(1:N);
y1 = A*cos(2*pi*f0*x1);
Ps = mean(abs(y1).^2);
Pb = Ps * 10^(-SNR/10);

%Bruit a ajouter

y2 = sqrt(Pb)*randn(1,N);
z = y1 + y2;

x_corr = xcorr(z);
x2 = linspace(-N,N,length(x_corr));
figure;
plot(x2,x_corr,'r');
xlabel("t en secondes");
ylabel("Signal")
title("Autocorrelation biaisé")
% Cet estimateur est biaisé car l'espérance est différente de
% l'auto-corrélation
% Le fait que l'estimateur soit biaisé ne pose aucun problème car il est
% toujours convergent.


% 
%Calcul du bruit
SNR = -10;
Pb = Ps * 10^(-SNR/10);
y2 = sqrt(Pb)*randn(1,N);
z = y1 + y2;

%Echelle temporelle des tracés
x1 = linspace(-N,N,length(y1));



x_corr = xcorr(z);
x2 = linspace(-N,N,length(x_corr));
figure;
subplot(221)
plot(x1,z,'g');
xlabel('t en secondes');
ylabel('Signal');
title('Cosinus bruité')

subplot(222)
plot(x2,x_corr,'r');
xlabel("t en secondes");
ylabel("Signal")
title("Autocorrelation biaisé")


%% 6.Estimation DSP
SNR = 10;

%Estimation par périodogramme de la DSP
N1 = length(z);
perio = (1/N)*(abs(fft(x,2^nextpow2(N))).^2);

%Estimation de la DSP par corrélogramme biaisé
corre = abs(fft(x_corr));
  

%Tracé des deux estimations
figure;
semilogy(linspace(-N,N,length(perio)),fftshift(perio),linspace(-N,N,length(corre)),fftshift(corre))
legend('Periodogramme','Corrélogramme')
xlabel('Frequence en Hz')
ylabel('Estimation de la DSP')
title('DSP par périodogramme et corrélogramme')


%Tracé en fréquences normalisées
figure;
semilogy(Te*linspace(-N,N,length(perio)),fftshift(perio),Te*linspace(-N,N,length(corre)),fftshift(corre))
legend('Periodogramme','Corrélogramme')
xlabel('Frequence normalisées f/Fe')
ylabel('Estimation de la DSP')
title('DSP par périodogramme et corrélogramme')
   