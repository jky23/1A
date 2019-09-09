%Osman Younes

%Paramètres en système international
f0=100;       %fréquence du cosinus 
Fe=10000;    %fréquence d'échantillonnage
Te=1/Fe;     %période d'échantillonnage
T0=1/f0 ;     %période du cosinus
N=(10*T0)/Te ;       %Nombre d'échantillons pour afficher le cosinus sur 10 périodes 
%Génération du signal
x=cos(2*pi*f0*[0:Te:N*Te]);
%Tracé du signal
figure(1)
plot([0:Te:N*Te],x)
title("cosinus sur 10 périodes")
xlabel("Temps(s)")
ylabel("x")
%Génération et tracé d'un brbonne journéeuit numérique
Pb = 1 % puissance du  bruit
b = sqrt(Pb) * randn(1,length(x));
figure(2)
plot([0:Te:N*Te],b)
title("tracé d'un bruit numérique gaussien")
xlabel("Temps(s)")
ylabel("b")
%Génération et tracé d'un signal bruité 
Ps=mean(abs(x).^2);%Puissance du signal
snr=10;%rapport signal sur bruit en decibel
Pb=Ps / (10^(snr/10));
x=x+b;%on rajoute du bruit au cosinus
figure(3)
plot([0:Te:N*Te],x)
title("tracé du signal bruité")
xlabel("Temps(s)")
ylabel("x")

%Estimation et tracé d'un fonction d'autocorrelation
r=xcorr(x) % autocorrelation biaisée  car  l'esperance de l'estimateur est differente de l'autocorrelation
% Le fait que l'autocorrelation soit biaisée n'est pas génant ( meilleur
% compromis biais variance)
% cosinus tend vers 0 dans les bords
figure(4)
plot([-N*Te:Te:N*Te],r)
title("tracé de l'autocorrelation du signal bruité  snr = 10")
xlabel("Temps(s)")
ylabel("r")
% Modification du rapport signal sur bruit à -10 et tracé du nouveau signal
% bruité ainsi que la fonction d'autocorrelation
snr = -10;
x=cos(2*pi*f0*[0:Te:N*Te]);
Ps=mean(abs(x).^2);
Pb=Ps / (10^(snr/10));
b = sqrt(Pb) * randn(1,length(x));
x=x+b;
r=xcorr(x);
figure(5)
plot([0:Te:N*Te],x)
title("tracé du signal bruité  snr = -10")
xlabel("Temps(s)")
ylabel("x")
figure(6)
plot([-N*Te:Te:N*Te],r)
title("tracé de l'autocorrelation du signal bruité  snr = -10")
xlabel("Temps(s)")
ylabel("r")
%Estimation de la densité spectrale de puissance en utilisant un
%periodogramme puis un correlogramme
snr = 10;
x=cos(2*pi*f0*[0:Te:N*Te]);
Ps=mean(abs(x).^2);
Pb=Ps / (10^(snr/10));
b = sqrt(Pb) * randn(1,length(x));
x=x+b;
r=xcorr(x);
sp=(1/length(x))*(abs(fft(x)).^2); % densité spectrale de puissance calculée par la formule du periodogramme
sc=abs(fft(r));% dsp calculée par la formule du correlogramme
%tracé de la dsp en fonction de la fréquence dans la même figure en echelle
%semi log
figure(7)
semilogy(linspace(-Fe/2,Fe/2,length(x)),sp,'r',linspace(-Fe/2,Fe/2,length(r)),sc,'b')
title("dsp periodogramme et correlogramme")
xlabel("Fréquence en Hz")
ylabel("sp et sc")
legend("periodogramme","correlogramme")

%Tracé de la dsp en échelle de fréquence normalisé
figure(8)
semilogy(linspace(-0.5,0.5,length(x)),sp,'r',linspace(-0.5,0.5,length(r)),sc,'b')
title("dsp periodogramme et correlogramme")
xlabel("Fréquence normalisée")
ylabel("sp et sc")
legend("periodogramme","correlogramme")
