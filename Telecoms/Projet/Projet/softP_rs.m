%% Generation de l'information binaire

N = 2000;             %nombre de data
bits = randi([0 1],1,2*N); %suite aleatoire de bits (QPSK)
M = 4;

bits(fix(2*N/(188*8) + 1)*(188*8)) = 0;

%% =====Codage canal=====

%% Reed solomon
Nb_bits_symboles = 8; % on manipules de octets
t = 8; % capacite de correction du code

K_RS = 188; % nombre de symboles du mot d'info RS
N_RS = K_RS + 2*t; % nombre de symboles du mot de code RS (apres codage)

H = comm.RSEncoder(N_RS,K_RS,'BitInput',true);
bits_code_RS=step(H,bits.').';

% %% Entrelacement
% nrows=12; %Nombre de registres (FIFO)
% slope=N_RS/nrows; %Taille des registres (FIFO)
% 
% Delai=nrows*(nrows-1)*slope; %Délai introduit
% 
% bits_paddes=[bits_code_RS zeros(1,Delai)];
% 
% %Entrelacement
% bits_entrelaces=convintrlv(bits_paddes,nrows,slope);

%% codage convolutif
k = 7;
polynomes = [171,133];

p_1 = [1 1];
p_2 = [1 0 1 1]; % 2/3
p_3 = [1 1 0 1 1 0]; %3/4
p_4 = [1 1 0 1 1 0 0 1 1 0]; %5/6
p_5 = [1 1 0 1 0 1 0 1 1 0 0 1 1 0]; %7/8

p_poinc = p_1;

trellis = poly2trellis(k, polynomes);

bitsEncodes = convenc(bits_code_RS, trellis, p_poinc);

%% Modulation

% Valeures initiales
Ts = 1/10^3;
Te = 1/10^4;
Ns = Ts/Te;         % Ns > 2 => condition de shannon
fp = 2*10^3;

% Mapping
symboles = 1 - bitsEncodes*2;        % Suite de symbole
symboles = symboles(1:2:end) + symboles(2:2:end)*1i; % Codage GRAY-QPSK

% Surechantillonnage
suite_dirac = upsample(symboles, Ns); %suite de dirac pondérée des ak

%filtrage de mise en forme
f_mise_en_forme = rcosdesign(0.35,6,Ns,"sqrt"); % filtre de mise en forme
retard = (length(f_mise_en_forme) - 1)/2;
    
s = filter(f_mise_en_forme, 1, [suite_dirac zeros(1, retard)]); % signal en sortie du modulateur
s = s(retard+1:end);

%% Canal de transmission AWGN %
rsb_dB = 0;
rsb = exp((rsb_dB/10)*log(10)); %Eb/N0 = ...
Pr = mean(abs(s).^2); % la puissance du signal recu

sigma = sqrt((Pr*Ns)/(2*2*rsb)); %puissance du bruit

bruit = randn(1, length(s) )*sigma + randn(1, length(s) )*sigma*1i;      %generation du bruit
s_bruite = s + bruit;  %ajout du bruit au signal
%% Demodulation

f_reception = f_mise_en_forme; % filtre de reception

r = s_bruite;

r = filter(f_reception, 1, [r zeros(1,retard)]);  %signal reçu
r = r(retard+1:end);

% Conclusion : t0 peut etre entre [Ts/2;Ts]
t0 = 1; %choix d'un t0 associe

r_echantillone = r(t0:Ns:end-1); %signal echantillone
r_e_decoupe = zeros(1,2*length(r_echantillone));
for i=1:length(r_echantillone)
    r_e_decoupe(2*i-1) = real(r_echantillone(i));
    r_e_decoupe(2*i) = imag(r_echantillone(i));
end

% Decodage soft
bitsDecodes_soft = vitdec(r_e_decoupe, trellis, 5*k, 'trunc', 'unquant', p_poinc);

%decision
seuil = 0; %seuil de decision adapte
signal_dk = r_e_decoupe < seuil;

% decodage hard
% bitsDecodes_hard = vitdec(signal_dk, trellis, 5*k, 'trunc', 'hard');
% 

%% =====Decodage canal=====

% %% Déentrelacement
% 
% bits_desentrelaces = convdeintrlv(bitsDecodes_soft, nrows, slope);
% Bits_retrouves=bits_desentrelaces(Delai+1:end);
% 
%% Demodulation Reed solomon

H = comm.RSDecoder(N_RS,K_RS,'BitInput',true);
bits_decodes_RS = step(H,bitsDecodes_soft.').';

%% TEB
%teb_soft = mean(bitsDecodes_soft ~= bits)
%teb_hard = mean(bitsDecodes_hard ~= bits)

teb = mean(bits_decodes_RS ~= bits)

%% Affichage des resultats
% figure();
% subplot(2,2,1);
% plot([1:length(s) ], real(s), 'r-');
% title("Phase du signal");
% 
% subplot(2,2,2);
% plot([1:length(s) ], imag(s), 'b-');
% title("Quadrature du signal");
% 
% %subplot(2,2,4);
% figure()
% plot(fftshift(abs(fft(s)).^2), 'r-');
% title("Densité spectrale de puissance de l'envelope signal");
% 
% subplot(2,2,3);
% hold on
% plot(r,'r-');
% title("Signal démodulé");
% 
% subplot(2,2,4);
% hold on
% plot(signal_detecte, 'r.');
% plot(symboles, 'b.')
% title("Comparaison signal detecte avec la suite initiale");
% legend("signal detecte", "suite de bits");

% %% Tracer les TEB en fonction du rsb
% rsbs_dB = [0:60]/10; % suite de RSB
% tebs_softP_rs = [];
% for rsb_dB=rsbs_dB % On parcours le RSB
%     teb_tmp = zeros(1,50);
%     for i=1:50  %Pour chaque valeur de RSB, on calcule le TEB 50 fois
%                 %Et on prendra la valeur moyenne
%         rsb = exp((rsb_dB/10)*log(10)); %Eb/N0 = ...
%         sigma = sqrt((Pr*Ns)/(2*2*rsb)); %puissance du bruit
% 
%         bruit = randn(1, length(s) )*sigma + randn(1, length(s) )*sigma*1j;      %generation du bruit
%         s_bruite = s + bruit;  %ajout du bruit au signal
% 
%         r = s_bruite;
% 
%         r = filter(f_reception, 1, [r zeros(1,retard)]);  %signal reçu
%         r = r(retard+1:end);
% 
%         r_echantillone = r(t0:Ns:end-1); %signal echantillone
%         
%         if (((rsb_dB == 0) || (rsb_dB == 3) || (rsb_dB == 6)) && (i == 1) )
%             figure(10)
%             plot(r_echantillone,'*'); hold on;
%         end
% 
%         signal_detecte = (real(r_echantillone) > seuil)*2 - 1 + (imag(r_echantillone) > seuil)*2i - 1i; %signal aprés decision et démappé
%         teb_tmp(i) = mean(signal_detecte ~= symboles); %taux d'erreur binaire
%     end
%     tebs_softP_rs = [tebs_softP_rs, mean(teb_tmp)];
% end
% teb_theorique = 2*(1-normcdf(sqrt(2*exp((rsbs_dB/10)*log(10)))));
% figure()
% semilogy(rsbs_dB, tebs_softP_rs);
% hold on
% semilogy(rsbs_dB, teb_theorique);
% title("le TEB en fonction du RSB");
% xlabel("RSB en dB");
% ylabel("TEB en echelle log");
% 
% figure(10)
% x = [-1 -1 +1 +1];
% y = [-1 +1 -1 +1];
% plot(x, y, 'ko'); hold on;
% plot([-2 2], [0 0], 'k-'); hold on;
% plot([0 0], [-2 2], 'k-');
% legend({'RSB = 0','RSB = 3','RSB = 6','Référence'});
% title('Constellation de sortie');
% xlim([-2 2]); ylim([-2 2]);
% grid on;