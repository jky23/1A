Ns = 20;
f0 = 200;
Fe = 1000;
Te = 1/Fe;
Ts = Ns*Te;
fc = f0/Fe;

%% Generation de l'information binaire
x = randi([0,1],Ns,1);

%Modulation bande de base
x = 2*x - 1;
m = kron(x,ones(Ns,1));
m = transpose(m);
M = periodogramme(m);


figure(1) 
subplot(221)
plot(linspace(-Fe/2,Fe/2,length(m)),m)
xlabel('t en secondes')
ylabel('Signal m(t)')
title('Signal NRZ')

subplot(222)
plot(linspace(-Fe/2,Fe/2,length(M)),fftshift(M),'-r')
xlabel('f en Hz')
ylabel('DSP')
title('DSP du Signal NRZ')

%Transposition de frequence
t = (1:Ns^2)/Fe;
f = cos(2*pi*f0*t);
x = m .* f;
X = periodogramme(x);

figure(2) 
subplot(221)
plot(linspace(-Fe/2,Fe/2,length(x)),x)
xlabel('t en secondes')
ylabel('Signal x(t)')
title('Signal transposé')
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(X)),fftshift(X),'-r')
xlabel('f en Hz')
ylabel('DSP')
title('DSP du Signal transposé')


%Canal AWGN
% Ajout d'un bruit gaussien de puissance 1
n = randn(1,Ns^2,1);
y = x+n;
Y = periodogramme(y);

figure(3) 
subplot(221)
plot(linspace(-Fe/2,Fe/2,length(y)),y)
xlabel('t en secondes')
ylabel('Signal y(t)')
title('Signal AWGN')
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(Y)),fftshift(Y),'-r')
xlabel('f en Hz')
ylabel('DSP')
title('DSP du signal AWGN')


%% Retour en bande de base
z= 2*y.*f;
Z = periodogramme(z);

figure(4) 
subplot(221)
plot(t,z)
xlabel('t en secondes')
ylabel('Signal z(t)')
title('Transposition de frequence')
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(Z)),fftshift(Z),'-r')
xlabel('f en Hz')
ylabel('z(t)')
title('DSP du signal transposé')


%% Filtre passe-bas
figure(6)
b = 2*fc*sinc(2*fc*t);
w = filter(b,1,z);
W = periodogramme(w);

plot(linspace(-Fe/2,Fe/2,length(b)),fftshift(abs(fft(b,length(b)))),linspace(-Fe/2,Fe/2,length(Z)),fftshift(Z))
xlabel('frequence en Hz')
ylabel('Reponse en frequence')
legend('Reponse en frequence','DSP de z(t)')
title('DSP et Reponse en frequence')

figure(7)
plot(linspace(-Fe/2,Fe/2,length(w)),w,linspace(-Fe/2,Fe/2,length(m)),m)
xlabel('t en secondes')
ylabel('w(t)')
legend('Signal w(t)','Signal m(t)')
title('Signal apres filtrage passe-bas')


