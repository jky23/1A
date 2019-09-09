clear all;
close all;
clc;


%% Constantes
nb_bits = 10000;
Ns = 10;
Te = 1;
Ts = Ns*Te;
M =2;
%Eb = 
%N0 = 
%sigma_n2 = 

%% Etude de la chaine de transmission en bande de base sur canal AWGN

% Generation de l'information binaire a transmettre à partir d'une image
Bits = randi([0,1],1,nb_bits);



%% Chaines de transmission à implanter

% 1ere chaine
  % Mapping binaire à moyenne nulle 0-> -1, 1->1
  Symboles_1 = 2*Bits - 1;
  
  % Suréchantillonage : generation de la suite de diracs pondérés
  Suite_diracs_1 = kron(Symboles_1,[1, zeros(1,Ns-1)]);
 
  % Reponse impulsionnelle du filtre de mise en forme
  h_1 = [ones(1,Ts/2),zeros(1,Ts/2)];
  
  %Filtrage de mise en forme
  x_1 = filter(h_1,1,Suite_diracs_1);
  
  % Reponse impulsionnelle du filtre de reception
  h_r_1 = h_1;
  
  % Filtrage de reception
  z_1 = filter(h_r_1,1,x_1); 
  
  % Diagramme de l'oeil
  n = size(z_1,2)/(2*Ns);
  z_til_1 = reshape(z_1,2*Ns,n);
  
  % Trace du diagramme
  figure;
  t = linspace(0,2*Ts,size(z_til_1,1));
  plot(z_til_1)
  xlabel('Periode Ts')
  title("Diagramme de l'oeil de la chaine 4")
  
  % Echantillonnage
  % Pour l'echantillonage on choisit t0 = Ts/2
  % Car l'oeil est ouvert pour t = Ts/2
  t0 = Ts/2;
  dec_1 = z_1(t0:Ts:end);
  
  % Prise de decisions
  n = size(dec_1,2);
  bits_recup = 1*(dec_1 > 0);
  
  % Calcul du TEB
  bits_erron = 0;
  for i = 1 : n
      if (Bits(i) ~= bits_recup(i))
          bits_erron = bits_erron + 1;
      end 
  end
  TEB_1 = bits_erron/n; 
  
  % Simulation du taux d'erreur binaire
  % Calcul de la puissance
  Pr = mean(abs(x_1).^2);
  TEB = zeros(1,7);
  for i = 0 : 6
      Eb_No = 10^(i/10);
      sigma = sqrt(Pr*Ns /(2*Eb_No));
      
      TEB_Theo(i+1) = 2*(M-1)/M.*qfunc(sqrt(6*log2(M)/(M^2-1)*Eb_No));
      
     % Rajout du bruit
      x_1_i = x_1 + (sigma*randn(1,nb_bits*Ns));
      
      % Filtrage de reception avec le bruit
      z_1_i = filter(h_r_1,1,x_1_i);
      
      % Echantillonage
      dec_1_i = z_1_i(t0:Ts:end);
      
      % Decisions
      % Prise de decisions
      n = size(dec_1_i,2);
      bits_recup_i = 1*(dec_1_i > 0);
      
      % Calcul du TEB
      bits_erron_i = 0;
      for j = 1 : n
          if (Bits(j) ~= bits_recup_i(j))
              bits_erron_i = bits_erron_i + 1;
          end
      end
      TEB(i+1) = bits_erron_i/nb_bits;
  end
  
  % Tracé du taux d'erreur binaire en fonction de Eb/No
  figure;
  semilogy(TEB,'o--')
  xlabel("Rapport Eb/No")
  ylabel("TEB")
  grid on;
  title("TEB en fonction de Eb/No")
  
  % Calcul du TEB theorique
  figure;
semilogy(TEB,'g')
hold on;
semilogy(TEB_Theo,'r')
grid on;
legend('TEB pratique', 'TEB theorique')
xlabel('Eb/N0')
ylabel('Valeur du TEB')
title('Comparaison des TEB')