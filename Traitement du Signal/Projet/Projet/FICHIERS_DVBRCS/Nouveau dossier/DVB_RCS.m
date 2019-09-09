% NOM : Benlemsieh
% PRENOM: Ismail
%Groupe : G
%Projet 2 DBR_RCS


clear all;
close all;


load donnees1.mat ;
load donnees2.mat;
%generer les bits
NRZ1 = 2*bits_utilisateur1 -1;
NRZ2 = 2*bits_utilisateur2 -1;
%parametres
fp1 = 0;
fp2 = 46000;
Fe = 120000;
Te = 1/Fe;
T1 = 1/fp1;
T2 = 1/fp2;
T=40*10^(-3);
N =T/Te;
SNR=10;
Nb = length(bits_utilisateur1);
Ts =(T/Nb);
Ns=Ts/Te;

m1= kron(NRZ1,ones(1,Ns));
m2 = kron(NRZ2,ones(1,Ns));
n1 = length(m1);
n2 = length(m2);

t= 0:Te:5*T-Te ;



cos1 = cos(2*pi*fp1*t);
cos2 = cos(2*pi*fp2*t);





%trace des signaux m1 et m2:

t1 = 0:Te:T-Te;

figure;
plot(t1,m1);
title('le signal m1');
xlabel('t');
ylabel('1 ou -1');

figure;
plot(t1,m2);
title('le signal m2');
xlabel('t');
ylabel('1 ou -1');

%trace des desnités spéctrales de m1 et m2 :
s1=(1/N)*abs(fft(m1,2^nextpow2(n1))).^2;
s2=(1/N)*abs(fft(m2,2^nextpow2(n2))).^2;
h1 = linspace(-Fe/2,Fe/2,length(s1));
h2 = linspace(-Fe/2,Fe/2,length(s2));

figure;
semilogy(h1,fftshift(s1));
title("densité spec de m1");
xlabel("f");
ylabel("m1");

figure;
semilogy(h2,fftshift(s2));
title("densité spec de m2");
xlabel("f");
ylabel("m2");








%les signaux à transmettre:

signal1=[zeros(1,N) m1 zeros(1,3*N)];
signal2=[zeros(1,4*N) m2];
x1=signal1*1; % cos(0)
x2=signal2.*cos2;
xs=x1+x2;

%bruit gaussion
Ps = mean(abs(xs).^2);
Pb = Ps*10^(-(SNR)/10);
n = length(xs);
sigma = sqrt(Pb);
noise = sigma*randn(1,n);

%signal bruite
x = xs + noise;

%trace de x
figure;
plot(t,x);
title("trace du x signal MF_TDMA");
xlabel("t");
ylabel("x");

%trace de la densitee spectrale de x 
x_spec = (1/N)*abs(fft(x,2^nextpow2(length(x)))).^2;
h = linspace(-Fe/2,Fe/2,length(x_spec));
figure;
semilogy(h,fftshift(x_spec));
title("trace de la densite spectrale de x signal MF_TDMA ");
xlabel("f");
ylabel("x");

%filtrage passe bas 
fc = 23000;
Nc = (61-1)/2;
n= [-Nc/Fe:1/Fe:Nc/Fe];
RI1 = 2*(fc/Fe)*sinc(2*fc*n);

%tracé de la réponse impulsionelle RI1
figure;
plot(n,RI1);
title("réponse impulsionelle du filtre passe bas");
xlabel("t");
ylabel("RI1");


%tracé de RI1 sur un échelle de fréquence 
figure;
semilogy(h,fftshift(abs(fft(RI1,length(x_spec)))));
title("fonction du transfert du filtre passe bas");
xlabel("f");
ylabel("RI1");



%filtrage passe bas apres le controle
x1_filtre = filter(RI1,1,[x zeros(1,Nc)]);
x1_filtre = x1_filtre(Nc+1:end); 

%filtrage passe haut 
%réponse impulsionelle du filtre passe haut
RI2 = -RI1;
RI2(Nc+1)= 1- RI2(Nc+1);

%tracé de la réponse impulsionelle RI2
figure;plot(n,RI2);
title("réponse impulsionelle du filtre passe haut");
xlabel("t");
ylabel("RI2");

%tracé de RI sur une échelle de fréquence
figure;
semilogy(h,fftshift(abs(fft(RI2,length(x_spec)))));
title("foction du transfert du filtre passe haut");
xlabel("f");
ylabel("RI2");


%signal filtré par le filtre passe haut
x2_filtre = filter(RI2,1,[x zeros(1,Nc)]);
x2_filtre = x2_filtre(Nc+1:end);


RI1s=fftshift(abs(fft(RI1,length(x_spec))));
x1s = fftshift(abs(fft(x1_filtre,length(x_spec))));
RI2s =fftshift(abs(fft(RI2,length(x_spec))));
x2s =fftshift(abs(fft(x2_filtre,length(x_spec))));
%tracé de x1 obtenu par filtrage passe bas
figure;
semilogy(h,fftshift(abs(fft(x1_filtre,length(x_spec)))));
title("densite spectral de x1 obtenu par filtrage passe bas ");
xlabel("f");
ylabel("x1");

%tracé de x2 obtenu par filtrage passe haut
figure;
semilogy(h,fftshift(abs(fft(x2_filtre,length(x_spec)))));
title("densite spectral de x2 obtenu par filtrage passe haut");
xlabel("f");
ylabel("x2");

%tracé de x1 et du filtre utilisé sur la meme courbe
figure;
semilogy(h,x1s,h,RI1s);
legend("signal reçu","filtre utilisé");
title("x1 et RI1 passe bas");
xlabel("f");

%tracé de x2 et du filtre utilisé sur la meme courbe
figure;
semilogy(h,x2s,h,RI2s);
legend("signal reçu","filtre utilisé");
title("x2 et RI2 passe haut");
xlabel("f");



%retour en bande
b1 = x1_filtre.*cos1;
b1 = filter(ones(1,Ns),1,b1);

b2 = x2_filtre.*cos2;
b2 = filter(ones(1,Ns),1,b2);

%tracé de la trame b1
figure;
semilogy(h,fftshift(abs(fft(b1,length(x_spec)))));
title("trame b1");
xlabel("f");
ylabel("b1");

%tracé de la trame b2
figure;
semilogy(h,fftshift(abs(fft(b2,length(x_spec)))));
title("trame b2");
xlabel("f");
ylabel("b2");




%Détection du slot util :

b2_divisee = reshape(b2,N,5);
e2=sum(b2_divisee.^2);
a2=max(e2);
%indice du slot util ( 5 pour la trame 2)
i2=find(e2==a2);
%slot utile
su2=b2((i2-1)*N+1:i2*N);

b1_divisee = reshape(b1,N,5);
e1 = sum(b1_divisee.^2);
a1 = max(e1);
%indice su slot util(1 pour la trame 1)
i1=find(e1==a1);
%slot util
su1=b1((i1-1)*N+1:i1*N);

%démosulation bande de base :
% su1_filtre = filter(ones(1,Ns),1,su1);
b1_echantillonne = su1(Ns:Ns:end);
BitsRecuperes1 =(sign(b1_echantillonne)+1)/2;

% su2_filtre = filter(ones(1,Ns),1,su2);
b2_echantillonne = su2(Ns:Ns:end);
BitsRecuperes2 =(sign(b2_echantillonne)+1)/2;

text1=bin2str(BitsRecuperes1)

text2=bin2str(BitsRecuperes2)





































  







