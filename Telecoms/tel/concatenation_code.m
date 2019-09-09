clear all;
precision = 100;
N = 20000;
nb_bit_max = 10^7;
rsbs_dB = (-3:3); % suite de RSB
bits = randi([0 1],1,2*N);  % Suite des bits à transmettre


figure()
teb_theorique = (1-normcdf(sqrt(2*10.^(rsbs_dB/10))));
semilogy(rsbs_dB, teb_theorique); 

hold on

tebs_hard = hard(bits,N, precision, rsbs_dB, nb_bit_max);
semilogy(rsbs_dB, tebs_hard);

hold on

tebs_soft = soft(bits,N, precision, rsbs_dB, nb_bit_max);
semilogy(rsbs_dB, tebs_soft);

hold on

tebs_softP = softP(bits,N, precision, rsbs_dB, nb_bit_max);
semilogy(rsbs_dB, tebs_softP);

hold on

tebs_softP_rs = softP_rs(bits,N, precision, rsbs_dB, nb_bit_max);
semilogy(rsbs_dB, tebs_softP_rs);

hold on

tebs_softP_inter_rs = softP_inter_rs(bits,N, precision, rsbs_dB, nb_bit_max);
semilogy(rsbs_dB, tebs_softP_inter_rs);

legend("hard", "soft", "softP", "softP_rs", "softP_inter_rs");
title("Comparaison des tracés des TEB");

