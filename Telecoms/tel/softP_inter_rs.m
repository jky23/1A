function [tebs_softP_inter_rs,bits_decodes_RS] = softP_inter_rs(bits,N, Nb_erreur_voulu, rsbs_dB, nb_bit_max)%Constantes

M = 4;

%pour reed solomon
Nb_bits_symboles = 8; % on manipules de octetS
t = 8; % capacite de correction du code

K_RS = 188; % nombre de symboles du mot d'info RS
N_RS = K_RS + 2*t; % nombre de symboles du mot de code RS (apres codage)

H_encode = comm.RSEncoder(N_RS,K_RS,'BitInput',true);
H_decode = comm.RSDecoder(N_RS,K_RS,'BitInput',true);

%pour entrelacement
nrows=12; %Nombre de registres (FIFO)
slope=N_RS/nrows; %Taille des registres (FIFO)

Delai=nrows*(nrows-1)*slope; %Délai introduit

%pour codage
k = 7;

polynomes = [171,133];

p_1 = [1 1];
p_2 = [1 0 1 1]; % 2/3
p_3 = [1 1 0 1 1 0]; %3/4
p_4 = [1 1 0 1 1 0 0 1 1 0]; %5/6
p_5 = [1 1 0 1 0 1 0 1 1 0 0 1 1 0]; %7/8

p_poinc = p_1;

trellis = poly2trellis(k, polynomes);

% pour modulation
Ts = 1/10^3;
Te = 1/10^4;
Ns = Ts/Te;         % Ns > 2 => condition de shannon
fp = 2*10^3;
f_mise_en_forme = rcosdesign(0.35,6,Ns,"sqrt"); % filtre de mise en forme
retard = (length(f_mise_en_forme) - 1)/2;
f_reception = f_mise_en_forme; % filtre de reception
t0 = 1; %choix d'un t0 associe


tebs_softP_inter_rs = [];
for rsb_dB=rsbs_dB % On parcours le RSB
    Nb_erreur = 0;
    Nb_passage = 0;
    
    rsb = 10^(rsb_dB/10); %Eb/N0 = ...
    while ((Nb_erreur < Nb_erreur_voulu)&&(Nb_passage < (nb_bit_max)/(2*N)))
      %  bits = randi([0 1],1,2*N); %suite aleatoire de bits (QPSK)
        bits(fix(2*N/(188*8) + 1)*(188*8)) = 0;
        
        %reed solomon
        bits_code_RS=step(H_encode,bits.').';
        
        % entrelacement
        bits_paddes=[bits_code_RS zeros(1,Delai)];
        bits_entrelaces=convintrlv(bits_paddes,nrows,slope);

        % codage convolutif
        bitsEncodes = convenc(bits_entrelaces, trellis, p_poinc);

        % Mapping
        symboles = 1 - bitsEncodes*2;        % Suite de symbole
        symboles = symboles(1:2:end) + symboles(2:2:end)*1i; % Codage GRAY-QPSK
        
        % Surechantillonnage
        suite_dirac = upsample(symboles, Ns); %suite de dirac pondérée des ak
        
        %filtrage de mise en forme
        
        s = filter(f_mise_en_forme, 1, [suite_dirac zeros(1, retard)]); % signal en sortie du modulateur
        s = s(retard+1:end);
        
        % generation du bruit
        Pr = mean(abs(s).^2); % la puissance du signal recu
        sigma = sqrt((Pr*Ns)/(2*2*rsb)); %puissance du bruit
        bruit = randn(1, length(s) )*sigma + randn(1, length(s) )*sigma*1j;      %generation du bruit
        
        s_bruite = s + bruit;  %ajout du bruit au signal
        
        r = s_bruite;
        
        r = filter(f_reception, 1, [r zeros(1,retard)]);  %signal reçu
        r = r(retard+1:end);
        
        r_echantillone = r(t0:Ns:end-1); %signal echantillone
        r_e_decoupe = zeros(1,2*length(r_echantillone));
        for j=1:length(r_echantillone)
            r_e_decoupe(2*j-1) = real(r_echantillone(j));
            r_e_decoupe(2*j) = imag(r_echantillone(j));
        end
                
        % decodage soft
        bitsDecodes_soft = vitdec(r_e_decoupe, trellis, 5*k, 'trunc', 'unquant', p_poinc);
        
        % desentrelacement
        bits_desentrelaces = convdeintrlv(bitsDecodes_soft, nrows, slope);
        Bits_retrouves=bits_desentrelaces(Delai+1:end);

        % decodage reed
        bits_decodes_RS = step(H_decode,Bits_retrouves.').';

        %teb
        Nb_erreur = Nb_erreur + sum(bits_decodes_RS ~= bits);
        Nb_passage = Nb_passage + 1;
    end
    tebs_softP_inter_rs = [tebs_softP_inter_rs, Nb_erreur/(Nb_passage*2*N)]
end
end
% teb_theorique = 2*(1-normcdf(sqrt(2*exp((rsbs_dB/10)*log(10)))));
% figure()
% semilogy(rsbs_dB, tebs_softP_inter_rs);
% hold on
% semilogy(rsbs_dB, teb_theorique);
% title("le TEB en fonction du RSB");
% xlabel("RSB en dB");
% ylabel("TEB en echelle log");
