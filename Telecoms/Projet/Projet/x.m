clear all;
close all;
%% Generation de l'information binaire
rsbs_dB = [-1:3]; % suite de RSB
tebs_softP_inter_rs = [];
TEB_Theo = [];
N = 188*10000;
M = 4;
for rsb_dB=rsbs_dB % On parcours le RSB
    Nb_erreur_voulu = 0;
    Nb_erreur = 0;
    Nb_passage = 0;
    
  %  while(Nb_erreur < Nb_erreur_voulu)
        
        teb_tmp = zeros(1,5);
        teb_tmp_theo = zeros(1,5);
        
        %nombre de data
        bits = randi([0 1],1,2*N); %suite aleatoire de bits (QPSK)
        
        
        %bits(fix(2*N/(188*8) + 1)*(188*8)) = 0;
        
        %% =====Codage canal=====
        %
        %% Reed solomon
        Nb_bits_symboles = 8; % on manipules de octets
        t = 8; % capacite de correction du code
        
        K_RS = 188; % nombre de symboles du mot d'info RS
        N_RS = K_RS + 2*t; % nombre de symboles du mot de code RS (apres codage)
        
        H = comm.RSEncoder(N_RS,K_RS,'BitInput',true);
        bits_code_RS=step(H,bits.').';
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
        %
        %% codage convolutif
        k = 7;
        polynomes = [171,133];
        
        p_1 = [1 1];
        p_2 = [1 0 1 1]; % 2/3
        p_3 = [1 1 0 1 1 0]; %3/4
        p_4 = [1 1 0 1 1 0 0 1 1 0]; %5/6
        p_5 = [1 1 0 1 0 1 0 1 1 0 0 1 1 0]; %7/8
        
        P = p_4;
        
        trellis = poly2trellis(k, polynomes);
        
        bitsEncodes = convenc(bits_code_RS, trellis, P);
        
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
        
        
        rsb = 10^(rsb_dB/10); %Eb/N0 = ...
        sigma = sqrt((Pr*Ns)/(2*2*rsb)); %puissance du bruit
        
        % while Nb_erreur < Nb_erreur_voulu
        
        
        bruit = randn(1, length(s) )*sigma + randn(1, length(s) )*sigma*1i;      %generation du bruit
        s_bruite = s + bruit;  %ajout du bruit au signal
        %% Demodulation
        
        r = s_bruite;
        f_reception = f_mise_en_forme; % filtre de reception
        
        r = filter(f_reception, 1, [r zeros(1,retard)]);  %signal reçu
        r = r(retard+1:end);
        
        t0 = 1;
        r_echantillone = r(t0:Ns:end-1); %signal echantillone
        r_e_decoupe = zeros(1,2*length(r_echantillone));
        for i=1:length(r_echantillone)
            r_e_decoupe(2*i-1) = real(r_echantillone(i));
            r_e_decoupe(2*i) = imag(r_echantillone(i));
        end
        
        % Decodage soft
        bitsDecodes_soft = vitdec(r_e_decoupe, trellis, 5*k, 'trunc', 'unquant', P);
        
        
        %         %% =====Decodage canal=====
        %
        %         %% Déentrelacement
        %
        %         bits_desentrelaces = convdeintrlv(bitsDecodes_soft, nrows, slope);
        %         Bits_retrouves=bits_desentrelaces(Delai+1:end);
        %
        %% Demodulation Reed solomon
        
        H = comm.RSDecoder(N_RS,K_RS,'BitInput',true);
        bits_decodes_RS = step(H,bitsDecodes_soft.').';
        
        
        
        teb_tmp = mean(bits_decodes_RS ~= bits);
        %taux d'erreur binaire
        %Eb_No = 10^(i/10);
        TEB_Theo_m =  2*(1-normcdf(sqrt(2*exp((rsb_dB/10)*log(10)))));
        
        
        %tmp_val = mean(teb_tmp);
        
        Nb_erreur = teb_tmp*length(bits);
  %  end
    % TEB_Theo_m = mean(teb_tmp_theo);
    
    
    tebs_softP_inter_rs = [tebs_softP_inter_rs, teb_tmp];
    TEB_Theo = [TEB_Theo  TEB_Theo_m];
    Nb_passage = Nb_passage + 1;
end

figure()
semilogy(rsbs_dB, tebs_softP_inter_rs);
hold on
title("le TEB en fonction du RSB");
xlabel("RSB en dB");
ylabel("TEB en echelle log");

% TEB_Theo = [];
% for i = -6 : 6
%     Eb_No = 10^(i/10);
%      TEB_Theo = [TEB_Theo (4*(1-(1/sqrt(M)))* qfunc(sqrt(3*log2(M)*Eb_No/(M-1))))/log2(M)];
% end
figure()
semilogy(rsbs_dB, tebs_softP_inter_rs);
hold on
semilogy(rsbs_dB, TEB_Theo);
legend("TEB simulé", "TEB Théorique")
title("le TEB en fonction du RSB");
xlabel("RSB en dB");
ylabel("TEB en echelle log");