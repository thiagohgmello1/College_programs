%% Trabalho de irradiação e ondas guiadas
clear all;
close all;
clc;

% Constantes
e0=1e-9/(36*pi);
mu0=4*pi*1e-7;
e_r=4.7;
fr=2.5e9; % Frequência de operação da antena
h=1.55e-3; % Altura
c=1/sqrt(mu0*e0);   

% Parâmetros
W=c/(2*fr)*sqrt(2/(e_r+1));
e_reff=(e_r+1)/2+(e_r-1)/(2*sqrt(1+12*h/W));
deltaL=0.412*h*(e_reff+0.3)*(W/h+0.264)/((e_reff-0.258)*(W/h+0.8));
L=c/(2*fr*sqrt(e_reff))-2*deltaL;






