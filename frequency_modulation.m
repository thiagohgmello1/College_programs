%Trabalho de Laboratório de Sistemas de Comunicação 
%Modulação FM 
%Alunos: Márcio Luiz Pinto da Silva Junior 
%         Mariana Christina Silva Perpétuo 
%         Thiago Henrique Gonçalves Mello

clc; close all; clear all; 

%Entrada de parâmetros
fc = input('Entre com a freq da portadora, em Hz: ');
fs = 100*fc; %frequencia de amostragem
    %Vetor de tempo
    t = 0:1/(fs):0.1;
Ac = input('Entre com a amplitude da portadora: ');
fmod = input('Entre com a freq da modulante, em Hz: ');
disp('Escolha o sinal modulante: (1) senoide, (2) dente de serra, (3) onda quadrada');
n = input('Entre com um número: ');

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

%Índice de modulação
mi = [0.25 1 2.4];

%Sinal modulado
figure(2)
y1 = Ac*sin(2*pi*fc*t + mi(1).*mod);
subplot(2,1,1)
plot(t,y1);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - índice de modulação 0.25');
subplot(2,1,2)
FFT(y1,fs);


figure(3)
y2 = Ac*sin(2*pi*fc*t + mi(2).*mod);
subplot(2,1,1)
plot(t,y2);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - índice de modulação 1');
subplot(2,1,2)
FFT(y2,fs);


figure(4)
y3 = Ac*sin(2*pi*fc*t + mi(3).*mod);
subplot(2,1,1)
plot(t,y3);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Sinal FM - índice de modulação 2.4');
subplot(2,1,2)
FFT(y3,fs);


