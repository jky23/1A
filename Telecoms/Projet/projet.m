%% Generation de l'information binaire

N = 2000;             %nombre de data
bits = randi([0 1],1,2*N); %suite aleatoire de bits (QPSK)
M = 4;

bits(fix(2*N/(188*8) + 1)*(188*8)) = 0;

%% =====Codage canal=====

%% Reed solomon
% Nb_bits_symboles = 8; % on manipules de octets
% t = 8; % capacite de correction du code
% 
% K_RS = 188; % nombre de symboles du mot d'info RS
% N_RS = K_RS + 2*t; % nombre de symboles du mot de code RS (apres codage)
% 
% H = comm.RSEncoder(N_RS,K_RS,'BitInput',true);
% bits_code_RS=step(H,bits.').';
% 
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

P = p_1;

trellis = poly2trellis(k, polynomes);

bitsEncodes = convenc(bits, trellis, P);

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
Pr = mean(abs(s).^2); % la puissance du signal recu

%% Tracer les TEB en fonction du rsb

%disp('La puissance du signal modulé sur fréquence porteuse est :'); Pr
TEB_bruit = zeros(1,7);
for i = 0 : 6
    Eb_No = 10^(i/10);
    sigma = sqrt(Ns*Pr/(2*log2(M)*Eb_No));
    
    
    TEB_Theo(i+1) = (4*(1-(1/sqrt(M)))* qfunc(sqrt(3*log2(M)*Eb_No/(M-1))))/log2(M);
    % Rajout du bruit
    N_I = sigma*randn(1,length(s));
    N_Q = sigma*randn(1,length(s));
    
    Ne = N_I + 1j*N_Q;
    
    x_1_i = s + Ne;
    
    h_r_1 = f_mise_en_forme;
    
    % Filtrage de reception avec le bruit
    z_x_i = filter(h_r_1,1,[x_1_i,zeros(1,retard)]);
    z_1_i = z_x_i(1,retard+1 : end);
    
    t0 = 1;
    r_echantillone = z_1_i(t0:Ns:end-1); %signal echantillone
    r_e_decoupe = zeros(1,2*length(r_echantillone));
    for j=1:length(r_echantillone)
        r_e_decoupe(2*j-1) = real(r_echantillone(j));
        r_e_decoupe(2*j) = imag(r_echantillone(j));
    end
    
    % Decodage soft
    bitsDecodes_soft = vitdec(r_e_decoupe, trellis, 5*k, 'trunc', 'unquant', P);
    
    %decision
    seuil = 0; %seuil de decision adapte
    signal_dk = r_e_decoupe < seuil;
    
    %decodage hard
    bitsDecodes_hard = vitdec(signal_dk, trellis, 5*k, 'trunc', 'hard');
    
    
    bits_decodes = bitsDecodes_soft;
    
    % Calcul du TEB
    bits_erron_i = 0;
    for j = 1 : length(bits)
        if (bits(j) ~= bits_decodes(j))
            bits_erron_i = bits_erron_i + 1;
        end
    end
    
    TEB_bruit(i+1) = bits_erron_i/2*N;
    
    
end

%figure;
semilogy(TEB_bruit, TEB_Theo);

hold on
title("le TEB en fonction du RSB");
xlabel("RSB en dB");
ylabel("TEB en echelle log");