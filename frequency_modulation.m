%Trabalho de Laborat�rio de Sistemas de Comunica��o 
%Modula��o FM 
%Alunos: M�rcio Luiz Pinto da Silva Junior 
%         Mariana Christina Silva Perp�tuo 
%         Thiago Henrique Gon�alves Mello

clc; close all; clear all; 

%Entrada de par�metros
fc = input('Entre com a freq da portadora, em Hz: ');
fs = 100*fc; %frequencia de amostragem
    %Vetor de tempo
    t = 0:1/(fs):0.1;
Ac = input('Entre com a amplitude da portadora: ');
fmod = input('Entre com a freq da modulante, em Hz: ');
disp('Escolha o sinal modulante: (1) senoide, (2) dente de serra, (3) onda quadrada');
n = input('Entre com um n�mero: ');

%Definindo o sinal modulante
switch n
    case 1
        disp('Sinal modulante -> senoide')
        mod = sin(2*pi*fmod*t);
    case 2
        disp('Sinal modulante -> dente de serra')
        mod = sawtooth(2*pi*fmod*t);
    case 3
        disp('Sinal modulante -> onda quadrada')
        mod =  square(2*pi*fmod*t);
    otherwise
        disp('Valor incorreto')
end

figure(1)
%plotando o sinal modulante
subplot(2,1,1);
plot(t,mod);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal modulante');

%Portadora
carry=Ac*sin(2*pi*fc*t);
subplot(2,1,2);
plot(t,carry);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Portadora');

%�ndice de modula��o
mi = [0.25 1 2.4];

%Sinal modulado
figure(2)
y1 = Ac*sin(2*pi*fc*t + mi(1).*mod);
subplot(2,1,1)
plot(t,y1);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - �ndice de modula��o 0.25');
subplot(2,1,2)
FFT(y1,fs);


figure(3)
y2 = Ac*sin(2*pi*fc*t + mi(2).*mod);
subplot(2,1,1)
plot(t,y2);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - �ndice de modula��o 1');
subplot(2,1,2)
FFT(y2,fs);


figure(4)
y3 = Ac*sin(2*pi*fc*t + mi(3).*mod);
subplot(2,1,1)
plot(t,y3);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - �ndice de modula��o 2.4');
subplot(2,1,2)
FFT(y3,fs);


