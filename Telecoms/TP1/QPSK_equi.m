clear all;
close all;
clc;

roll_of = 0.35;
fp = 2000;
Rs = 1000;
Fe = 10000;
Te = 1/Fe;
Ns = 10;
Ts = 1/Rs;
Fc1 = fp/Fe;
Nech = 30;
M = 4;

nb_bits = 10000;
g1 = 5;
g2 = 7;

%% Implantation de la chaine passe-bas equivalente

% Generation des bits à transmettre
Bits = randi([0,1],1,nb_bits);

%% Codage canal

% Codage convolutif

%generation du trellis
trellis = poly2trellis(3, [g1 g2]);

% codage convolutif
Bits = convenc(Bits, trellis, P);

% Mapping de Gray
ak = Bits(1:2:end);
bk = Bits(2:2:end);
ak = 2*ak -1;
bk = 2*bk-1;
dk = ak + 1j*bk;

% Tracé des constellations
figure;
plot(ak,bk, 'rd')
hold on, plot([-2 2],[0 0],'k-')
hold on, plot([0 0], [-2 2], 'k-')
xlabel('I')
ylabel('Q')
title("Tracé des constellations")


% Suréchantillonage : génération de la sutite de diracs
Suite_diracs_1 = kron(dk,[1, zeros(1,Ns-1)]);


% Reponse impulsionnelle du filtre de mise en forme
h_1 = rcosdesign(roll_of,6,Ns,'sqrt');
retard = (length(h_1) - 1)/2;

% Filtrage de mise en forme
x_1 = filter(h_1,1,[Suite_diracs_1,zeros(1,retard)]);

% Tracé des signaux générés sur les voies
figure;
subplot(221)
plot(real(x_1), 'r')
xlabel('t')
ylabel('I(t)')
title('Signal généré sur la voie I')


subplot(222)
plot(imag(x_1),'b')
xlabel('t')
ylabel('Q(t)')
title('Signal généré sur la voie Q')


% Calcul et tracé de la DSP par la methode du périodogramme
figure;
dsp = (abs(fft(real(x_1))).^2)/length(real(x_1));
tx = linspace(-Fe/2,Fe/2,length(dsp));
plot(tx,fftshift(dsp),'r')
xlabel('f en Hz')
ylabel('DSP')
title('Tracé de la DSP du signal modulé sur porteuse')




% Filtre de reception
h_r_1 = h_1;   % filtrage adapté

% Filtrage de reception
z_1 = filter(h_r_1,1,[x_1,zeros(1,retard)]);
z_1 = z_1(1,2*retard+1:end);

% Diagramme de l'oeil
n = size(z_1,2)/(2*Ns);
z_til_real = real(z_1);
z_til_im = imag(z_1);
z_til_real = reshape((z_til_real),2*Ns,n);
z_til_im = reshape((z_til_im),2*Ns,n);

% Trace du diagramme
figure;
t2 = linspace(0,2*Ts,size(z_til_real,1));
plot(t2,z_til_real)
xlabel('Periode Ts')
title("Diagramme de l'oeil de la chaine I QPSK")

figure;
t2 = linspace(0,2*Ts,size(z_til_im,1));
plot(t2,z_til_im)
xlabel('Periode Ts')
title("Diagramme de l'oeil de la chaine Q QPSK")

% Echantillonnage
% Pour l'echantillonage on choisit t0 = Ts
% Car l'oeil est ouvert pour t = Ts
t0 = 1;
im_z = imag(z_1);
real_z = real(z_1);
dec_real = real_z(t0:Ns:end);
dec_im = im_z(t0:Ns:end);

% Prise de decisions
n = size(dec_real,2);
bits_real = (dec_real > 0);
bits_im = (dec_im > 0);
bits_recup = zeros(1,2*n);
for i = 1 : n
    bits_recup(2*i -1) = bits_real(i);
    bits_recup(2*i) = bits_im(i);
end

% Calcul du TEB
bits_erron = 0;
for i = 1 : length(Bits)
    if (Bits(i) ~= bits_recup(i))
        bits_erron = bits_erron + 1;
    end
end
TEB = bits_erron/length(Bits);

% Calcul de la puissance du signal
Pr = mean(abs(x_1).^2);


% Simulation du taux d'erreur binaire
% Calcul de la puissance

%disp('La puissance du signal modulé sur fréquence porteuse est :'); Pr
TEB_bruit = zeros(1,7);
for i = 0 : 6
    Eb_No = 10^(i/10);
    sigma_real = sqrt(Ns*Pr/(2*log2(M)*Eb_No));
    sigma_im = sqrt(Ns*Pr/(2*log2(M)*Eb_No));
    
    TEB_Theo(i+1) = (4*(1-(1/sqrt(M)))* qfunc(sqrt(3*log2(M)*Eb_No/(M-1))))/log2(M);
    % Rajout du bruit
    N_I = sigma_real*randn(1,(nb_bits*Ns/2) +retard);
    N_Q = sigma_im*randn(1,(nb_bits*Ns/2) +retard);
    
    Ne = N_I + 1j*N_Q;
    
    x_1_i = x_1 + Ne;
    
    
    % Filtrage de reception avec le bruit
    z_x_i = filter(h_r_1,1,[x_1_i,zeros(1,retard)]);
    z_1_i = z_x_i(1,2*retard+1 : end);
    
    % Echantillonnage
    % Pour l'echantillonage on choisit t0 = Ts
    % Car l'oeil est ouvert pour t = Ts
    t0 = 1;
    im_z = imag(z_1_i);
    real_z = real(z_1_i);
    dec_real = real_z(t0:Ns:end);
    dec_im = im_z(t0:Ns:end);
    
    % Prise de decisions
    n = size(dec_real,2);
    bits_real = (dec_real > 0);
    bits_im = (dec_im > 0);
    bits_recup_i = zeros(1,2*n);
    for k = 1 : n
        bits_recup_i(2*k -1) = bits_real(k);
        bits_recup_i(2*k) = bits_im(k);
    end
    
    % Calcul du TEB
    bits_erron_i = 0;
    for j = 1 : length(Bits)
        if (Bits(j) ~= bits_recup_i(j))
            bits_erron_i = bits_erron_i + 1;
        end
    end
    
    TEB_bruit(i+1) = bits_erron_i/nb_bits;
    
    % Tracé des constellations
      figure(21)
    subplot(3,4,i+1)
    plot(dec_real,dec_im, 'r.')
    hold on, plot([-4 4],[0 0],'k-')
    hold on, plot([0 0], [-4 4], 'k-')
    xlabel('I')
    ylabel('Q')
    title(["Constellations pour Eb/No = ",i,"Db"])
end

% Tracé du taux d'erreur binaire en fonction de Eb/No
figure;
semilogy(TEB_bruit,'o--')
grid on;
xlabel("Rapport Eb/No")
ylabel("TEB")
title("TEB en fonction de Eb/No")

% Calcul du TEB theorique
figure;
semilogy(TEB_bruit,'g')
hold on;
semilogy(TEB_Theo,'r')
grid on;
legend('TEB pratique', 'TEB theorique')
xlabel('Eb/N0')
ylabel('Valeur du TEB')
title('Comparaison des TEB')


figure;
TEB_theo_1 = importdata( 'TEB_bpsk.mat');
TEB_theo_2 = importdata( 'TEB_8psk.mat');
TEB_theo_3 = importdata( 'TEB_16qam.mat');
%TEB_theo_4 = importdata( 'TEB4.mat');
semilogy(TEB_theo_1,'r-s')
hold on;
semilogy(TEB_theo_2,'k-d')
hold on;
semilogy(TEB_theo_3,'b-x')
hold on;
semilogy(TEB_bruit,'g-o')
hold on;
grid on;
legend('chaine BPSK','chaine 8PSK','chaine 16QAM','chaine QPSK')
xlabel('Eb/N0')
ylabel('Valeur du TEB')
title('Comparaison des chaines en efficacité en puissance')



