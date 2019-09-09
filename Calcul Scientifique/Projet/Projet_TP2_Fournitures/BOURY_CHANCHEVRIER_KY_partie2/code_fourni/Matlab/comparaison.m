clear all;
close all;
clc;

X1 = load ('spectrum_1.txt');
X2 = load ('spectrum_2.txt');
X3 = load ('spectrum_3.txt');
X4 = load ('spectrum_4.txt');

%Comparaison des valeurs propres des differentes matrices
figure;
plot(X1,'o-r'),hold on;
plot(X2,'o-y'),hold on;
plot(X3,'o-k'),hold on;
plot(X4,'o-b'),hold on;
legend('Matrice 1','Matrice 2','Matrice 3','Matrice 4')
xlabel('Numero de la valeur propre')
ylabel('Valeur de la valeur propre')
title('Distribution des valeurs propres des matrices')