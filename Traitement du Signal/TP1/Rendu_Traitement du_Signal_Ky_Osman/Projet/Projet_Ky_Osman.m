load donnees1.mat
load donnees2.mat

fp1 = 0;
fp2 = 46000;
Fe = 120000;
Fc1 = 10000/Fe;
Fc2 = 36000/Fe;
Te = 1/Fe;
T_slot = 40*10^(-3);
n = length(bits_utilisateur1);
Ts = T_slot/n;
Ns = Ts/Te;
SNR = 10;
Nech = 30;


%% 3.1
%Generation des fichiers m1(t) m2(t)
y1 = bits_utilisateur1;
y2 = bits_utilisateur2;
y1 = 2*y1 - 1;
y2 = 2*y2 - 1;
m1 =  kron(y1,ones(1,Ns));
m2 =  kron(y2,ones(1,Ns));
% On obtient le signal NRZ de chaque utilisateur

%3.2
%3.2.1
%Generer le signal comportant 5 slots
% et y placer les signaux NRZ générés

slt_1 = zeros(1,5*length(m1));  %Signal des 05 slots du 1er utilisateur
slt_2 = zeros(1,5*length(m2));  %Signal des 05 slots du 2nd utilisateur

slt_1(n*Ns +1:n*Ns*2) = m1;
slt_2(n*Ns*4+1:end) = m2;


%3.2.2
%Generation des cosinus porteurs de chaque utilisateur
t = (0:Te:5*T_slot-Te);

porteur_1 = cos(2*pi*fp1*t);
porteur_2 = cos(2*pi*fp2*t);

%Generation des signaux multiliés par les porteuses
x1 = slt_1.*porteur_1;
x2 = slt_2.*porteur_2;

%Construction du signal MF-TDMA recu
x = x1 +x2;
%Generation du bruit blanc
Ps = mean(abs(x).^2);
Pb = Ps*10^(-SNR/10);
sigma = sqrt(Pb);
N = sigma*randn(1,length(x));
x = x+N;

%% Tracés a realiser
% Tracés des signaux m1(t) m2(t) ainsi que leurs densités
t1 = (0:Te:T_slot - Te);  %Echelle temporelle des tracés
figure(1) % Tracés de m1 et sa densité
subplot(212)
plot(t1,m1,'b')
title('Signal NRZ de l''utilisateur1')
xlabel('t en s')
ylabel('m1(t)')
M = periodogramme(x1);
tx = linspace(-Fe/2,Fe/2,length(M));
subplot(211)
plot(tx,fftshift(M),'r')
title('Tracé de la DSP')
xlabel('f en Hz')
ylabel('DSP')




figure(2) % Tracés de m2 et sa densité
subplot(212)
plot(t1,m2,'b')
title('Signal NRZ de l''utilisateur2')
xlabel('t en s')
ylabel('m2(t)')
M1 = periodogramme(x2);
tx = linspace(-Fe/2,Fe/2,length(M1));
subplot(211)
plot(tx,(M),'r')
title('Tracé de la DSP')
xlabel('f en Hz')
ylabel('DSP')




figure(3) % Tracés de la trame MF-TDMA

plot(t,x,'.')
title('Tracé de la trame MF-TDMA')
xlabel('t en s')
ylabel('MF-TDMA')


figure(4)
X = periodogramme(x);
tx = linspace(-Fe/2,Fe/2,length(X));
plot(tx,fftshift(X),'r')
title('Tracé de la DSP de la trame')
xlabel('frequence en Hz') 



%% 4.1
%4.1.1 Synthese du Filtre passe bas
% Reponse impulsionnelle
t1 = [-Nech:Nech];
b = 2*Fc1*sinc(2*Fc1*t1);  


%4.1.2 Synthese du filtre passe haut
% Reponse impulsionnelle
b1 = 2*Fc2*sinc(2*Fc2*t1);
b1 = -b1;
b1(Nech+1) = 1 -2*Fc2;


%4.1.3 Filtrage
x1t = filter(b,1,[x zeros(1,Nech)]);
x2t = filter(b1,1,[x zeros(1,Nech)]);
x1t = x1t(Nech+1:end);
x2t = x2t(Nech+1:end);



%4.1.4 Retour en bande de base

%Multiplication par les cosinus porteurs
x1t_t = x1t .* cos(2*pi*fp1*t); 
x2t_t = x2t .* cos(2*pi*fp2*t);

%Reponses impulsionnelles des filtres passe-bas
o = ones(1,Ns);

%Filtrage
x1f = filter(o,1,x1t_t);
x2f = filter(o,1,x2t_t);

%% 4.1.5 Tracés a réaliser

%Tracés des reponses impulsionnelles et de la fonction de transfert de
%l'utilisateur 1
figure(5)
t2 = linspace(-Fe/2,Fe/2,length(b));
plot(t2,b,'b--o')
title('Reponse impulsionnelle PB')
xlabel('t en s')
ylabel('RI')


figure(6)
plot(tx,100*fftshift(abs(fft(b,length(x)))),'b',tx,fftshift(X),'r');
legend('filtre PB','DSP MF-TDMA')
title('Reponse en frequence du filtre passe bas')
xlabel('f')
ylabel('H(z)')

%Tracés des reponses impulsionnelles et de la fonction de transfert de
%l'utilisateur 2
figure(7)
plot(t2,b1,'b--o')
title('Reponse impulsionnelle PH')
xlabel('t en s')
ylabel('RI')


figure(8)
plot(tx,100*fftshift(abs(fft(b1,length(x)))),'b',tx,fftshift(X),'r');
legend('filtre PH','DSP MF-TDMA')
title('Reponse en frequence du filtre passe haut')
xlabel('f')
ylabel('H(z)')





figure(9)
plot(t,x,'.')
title('Signal avant filtrage PB')
xlabel('t en s')
ylabel('x(t)')

figure(10)
plot(t,x1t,'.')
title('Signal apres filtrage PB')
xlabel('t en s')
ylabel('x1t(t)')


figure(11)
plot(t,x,'.')
title('Signal avant filtrage PH')
xlabel('t en s')
ylabel('x(t)')

figure(12)
plot(t,x2t,'.')
title('Signal apres filtrage PH')
xlabel('t en s')
ylabel('x2t(t)')



figure(13)
plot(t,x1f,'.')
title('Trame du signal récupérée par l''utilisateur1')
xlabel('t en s')
ylabel('x1f(t)')


figure(14)
plot(t,x2f,'.')
title('Trame du signal recupérée par l''utilisateur2')
xlabel('t en s')
ylabel('x2f(t)')


%% 4.2 Detection du slot utile
% Utilisateur 1 
% Division en 5 slots


E_1 = zeros(1,5);% Vecteur contenant les energies de chaque slot de l'utilisateur 1 
for i=1 : 5
    E_1(i) = sum(x1f(n*Ns*(i-1)+1:n*Ns*i).^2);
end
[~,argmax1] = max(E_1);
X = x1f((n*Ns*(argmax1-1))+1 : n*Ns*argmax1); %Trame de l'utilisateur 1 récupérée

%Utilisateur 2
% Division en 5 slots



E_2 = zeros(1,5); %Vecteur contenant les energies de chaque slot de l'utilisateur 2
for i=1 : 5
     E_2(i) = sum(x2f(n*Ns*(i-1)+1:n*Ns*i).^2);
end
[~,argmax2] = max(E_2);
Y = x2f((n*Ns*(argmax2-1))+1 : n*Ns*argmax2); %Trame de l'utilisateur 2 récupérée

% Histogramme des energies détectées par slots
figure(15)
bar(E_1)
title("Energie détectée par l'utilisateur 1")
xlabel('Numéro du slot')
ylabel('Energie')
figure(16)
bar(E_2)
title("Energie détectée par l'utilisateur 2")
xlabel('Numéro du slot')
ylabel('Energie')

%% 4.3 Demodulation bande de base
%Utilisateur1

SignalEchantillonne_1= X(Ns :Ns :end) ;
BitsRecuperes_1=(sign(SignalEchantillonne_1)+1)/2 ;

texte1 = bin2str(BitsRecuperes_1)


%Utilisateur2

SignalEchantillonne_2= Y(Ns :Ns :end) ;
BitsRecuperes_2=(sign(SignalEchantillonne_2)+1)/2 ;

texte2 = bin2str(BitsRecuperes_2)


