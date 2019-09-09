%
% ~gergaud/ENS/Automatique/TP18-19/TP2/Etudiants/exemple_test_pendule_inv.m
%
% Auteur : Gergaud Joseph
% Date : october 2018
% Institution : Université de Toulouse, INP-ENSEEIHT
%               Département Sciences du Numérique
%               Informatique, Mathématiques appliquées, Réseaux et Télécommunications
%               Computer Science department
%
%-----------------------------------------------------------------------------------------
%
% Code Matlab de test pour la simulation du pendule inversé contrôlé. 
%
%-----------------------------------------------------------------------------------------


% Remarque : On ne fait pas de sous programme car Simulink utilise
% l'environnement Matlab
%
clear all; close all;
addpath('./Ressources');
% Pour une figure avec onglet
set(0,  'defaultaxesfontsize'   ,  12     , ...
   'DefaultTextVerticalAlignment'  , 'bottom', ...
   'DefaultTextHorizontalAlignment', 'left'  , ...
   'DefaultTextFontSize'           ,  12     , ...
   'DefaultFigureWindowStyle','docked');
%
% Initialisations
% ---------------
t0 = 0;             % temps initial
xe = [0 0 0 0];     % (x_e, u_e) point de fonctionnement
ue = 0;             %

% Cas 1
% -----

fich_simulink_etu = './robot_capteur_etu'

% Cas 1.1

 
fich = 'cas1_1';
x0 = [0 0 0 0];
tf = 2;             % temps final
K = [0 0 0 0];
algorithme = 'ode45';
RelTol = '1e-3';

test_robot


% Cas 1.2

fich = 'cas1_2';

tf = 2;             % temps final

load matrices       % on importe le workspace de matrices.m
                   

% A compléter
 x0 = [0 pi/10 0 0]; % initial point
 V = poles;
 K = -place(A,B,V); % on calcule K à partir de A, B et poles( = V) 
 algorithme = 'ode45';
 RelTol = '1e-3';

test_robot

