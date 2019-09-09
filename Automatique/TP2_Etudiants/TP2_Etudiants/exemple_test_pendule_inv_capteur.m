%
% ~gergaud/ENS/Automatique/TP18-19/TP2/Etudiants/test_pendule_inv.m
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
fich_simulink = './pendule_inv_capteur_etu'
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
g = 9.81; l = 10;   % constantes
xe = [0 0];         % (x_e, u_e) point de fonctionnement
ue = 0;             %

% Cas 1
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas1';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode45';
RelTol = '1e-3';

test_pendule_inv_capteur



% Cas 2
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas2';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode45';
RelTol = '1e-10';

test_pendule_inv_capteur


% Cas 3
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas3';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode1';
pas = 0.001;

test_pendule_inv_capteur


% Cas 4
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas4';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode1';
pas = 1;

test_pendule_inv_capteur


% Cas 5
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas5';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode1';
pas = 2;

test_pendule_inv_capteur


% Cas 6
% -----
x0 = [pi/20 0];       % initial point

% Cas 
fich = 'cas6';

tf = 100;              % temps final
K = [10 1];
algorithme = 'ode1';
pas = 5;

test_pendule_inv_capteur
