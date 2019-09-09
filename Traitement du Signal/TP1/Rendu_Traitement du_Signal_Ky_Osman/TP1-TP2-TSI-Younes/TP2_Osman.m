%Osman Younes

N =  10 ; % nombre de chiffre binaires
Fe = 1000 ; %Hz
Te = 1/Fe ;
F0 = 200 ; % Hz
Ns = 20; % échantillons par niveau
Ts = Ns * Te ;
A = randi ( [0,1] , 1 , N );  % génération d'une ligne de n éléments qui contient une suite binaire de 0 et de 1
m = ones (1 , N*Ns) ; % on crée une ligne qui contient n*Ns 1 qu'on modifiera par la suite en fonction de notre ligne de suite binaire
for i = 1:N-1
    if A(i) == 0
        m(Ns*i:Ns*(i+1)) = -1 ;
    end 
end
sm=abs(fft(m).^2);%densité spectrale de puissance de m
%Tracé du signal m ainsi que sa densité spectrale de puissance
figure(1)
subplot(221)
plot((0:N*Ns-1)*Te,m,'*r',(0:N*Ns-1)*Te,m)
title("tracé de m")
xlabel("Temps(s)")
ylabel("m")
figure(1)
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(h)),sm)
title("tracé de la densité spectrale de puissance")
xlabel("Fréquence en Hz")
ylabel("sm")

% a la fin de cette boucle for nous aurons le signal NRZ m(t) voulu ;
% génération du cosinus numérique
cosinus = cos (2*pi*F0*(0:N*Ns-1)*Te);
%Transposition de frequence 
x = cosinus .* m;
sx=abs(fft(x));
%Tracé de x ainsi que sa densité spectrale de puissance
figure(2)
subplot(221)
plot((0:N*Ns-1)*Te,x)
title("tracé de x")
xlabel("Temps(s)")
ylabel("x")
figure(2)
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(sx)),sx)
title("densité spectrale de puissance de x")
xlabel("Fréquence(Hz)")
ylabel("sx")
% génération de bruit blanc gaussien  de rapport signal sur bruit SNR  = 100
Snr = 100 ;
Ps=mean(abs(x).^2);
Pb = Ps / 10^(Snr / 10);
n = sqrt(Pb)* randn(1,N*Ns);
% Canal de transmission AWGN 
y = x + n ;
%Retour en bande de base 
% Multiplication de y par le même cosinus 
z = (2*y) .* cosinus;
sz=abs(fft(z));
%Tracé de z ainsi que sa densité spectrale de puissance
figure(3)
subplot(221)
plot((0:N*Ns-1)*Te,z)
title("tracé de z")
xlabel("Temps(s)")
ylabel("z")
figure(3)
subplot(222)
plot(linspace(-Fe/2,Fe/2,length(sz)),sz)
title("densité spectrale de puissance de z")
xlabel("Fréquenctracée(Hz)")
ylabel("sz")
% LPF filtrage passe bas
h = F0 * sinc(F0*(0:N*Ns-1)*Te); % réponse impulsionnelle du filtre rif passe-bas
%tracé sur la même figure de la réponse en fréquence du filtre ainsi que la dsp
%du signal z à filtrer
figure(4)
subplot(221)
plot(linspace(-Fe/2,Fe/2,length(h)),fftshift(abs(fft(h))))
title("réponse en fréquence du filtre passe bas")
xlabel("Fréquence en Hz")
ylabel("H")
figure(4)
subplot(222)
plot((0:N*Ns-1)*Fe,sz)
title("densité spectrale de puissance de z")
xlabel("Fréquence(Hz)")
ylabel("sz")
%filtrage de z 
w = filter (h,1,z);
sw=abs(fft(w));
%tracé de la densité spectrale de puissance du signal filtré
figure(5)
plot(linspace(-Fe/2,Fe/2,length(sw)),fftshift(sw))
title("densité spectrale de puissance de w")
xlabel("Fréquence(Hz)")
ylabel("sw")
%tracé du signal filtré et comparaison avec m sur la même figure
figure(6)
subplot(221)
plot((0:N*Ns-1)*Te,m)
title("tracé de m")
xlabel("Temps(s)")
ylabel("m")
figure(6)
subplot(222)
plot((0:N*Ns-1)*Te,w)
title("tracé de w")
xlabel("Temps(s)")
ylabel("w")
