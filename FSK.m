%% Trabalho de sistemas de comunicação
% Alunos: Márcio Luiz Pinto da Silva Júnior, Mariana Christina Silva Perpé-
%         tuo, Thiago Henrique G. Mello
% Professor: Arnaldo da Silva Avidago
% Programa para modulação de uma onda através de modulação 4-FSK

clear all;
clc;

% Textos
text_port={'Frequência 1 (Hz):','Frequência 2 (Hz):','Frequência 3 (Hz):'...
       'Frequência 4 (Hz):','Amplitude(V):','Frequência de amostragem:'};
text_mod={'Frequência (bit/s):','Dado (par de bits):'};
def_port={'1000','2000','3000','4000','5','10000'};
def_mod={'500','00011011'};
d_title1='Dados das portadoras';
d_title2='Dados da modulante';
dim=[1 50];

% Caixas de diálogo
opts.Interpreter = 'tex';
vec_port=inputdlg(text_port,d_title1,dim,def_port);
vec_mod=inputdlg(text_mod,d_title2,dim,def_mod);

% Informações para as portadoras
fc1=str2double(vec_port(1)); % Dado 00
fc2=str2double(vec_port(2)); % Dado 01
fc3=str2double(vec_port(3)); % Dado 10
fc4=str2double(vec_port(4)); % Dado 11
amp=str2double(vec_port(5)); % Amplitude das portadoras
fs=str2double(vec_port(6)); % Frequência de amostragem
Ts=1/fs;

% Informações para os dados
fm=str2double(vec_mod(1));
data=cell2mat(vec_mod(2));
data=reshape(data,[],1);
data=str2num(data);

% Parâmetros
T=1/fm; % Período da modulante
res=0:Ts:1; % Resolução
t=res*T;
tam=length(data);

% Tratamento dos dados
aux2=0;
for i=1:2:(length(data)-1)
    aux=and(data(i),data(i+1));
    aux2=aux2+1;
    if aux==1
        wave(:,aux2)=amp*sin(2*pi*fc4*2*t); % 11
    elseif aux==0
        if data(i)==1
            wave(:,aux2)=amp*sin(2*pi*fc3*2*t); % 10
        elseif data(i)==0
            if data(i+1)==0
                wave(:,aux2)=amp*sin(2*pi*fc1*2*t); % 00
            else
                wave(:,aux2)=amp*sin(2*pi*fc2*2*t); % 01
            end
        end
    end
end
v=reshape(wave,[],1);
t2=(1:1:length(v))/length(v)*T*length(data)/2;
vc1=amp*sin(2*pi*fc1*t);
vc2=amp*sin(2*pi*fc2*t);
vc3=amp*sin(2*pi*fc3*t);
vc4=amp*sin(2*pi*fc4*t);

% Vetores de sinal
aux2=0;
for i=1:length(data)
    for j=1:(length(t))
        aux=aux2+j;
        sinal(aux)=data(i);
    end
    aux2=length(sinal);
end
t3=(1:1:length(sinal))*T*length(data);
t3=t3/length(t3);

% Gráficos

figure(1);
subplot(2,1,1);
plot(2*t2,v);
axis([0 max(2*t2) -amp amp]);
title('Sinal modulado')
suptitle('Sinais');
xlabel('tempo[s]');
ylabel('Amplitude[V]');
subplot(2,1,2);
plot(t3,sinal);
axis([0 t3(length(t3)) 0 1]);
title('Sinal modulante');
xlabel('tempo[s]');
ylabel('Amplitude[V]');

%
f_xaxis=min([fc1 fc2 fc3 fc4]);
figure(2);
subplot(4,1,1);
plot(t,vc1);
axis([0 1/f_xaxis -amp amp]);
title(['f_{p}=',num2str(fc1),'Hz']);
subplot(4,1,2);
plot(t,vc2);
axis([0 1/f_xaxis -amp amp]);
title(['f_{p}=',num2str(fc2),'Hz']);
subplot(4,1,3);
plot(t,vc3);
axis([0 1/f_xaxis -amp amp]);
title(['f_{p}=',num2str(fc3),'Hz']);
subplot(4,1,4);
plot(t,vc4);
axis([0 1/f_xaxis -amp amp]);
title(['f_{p}=',num2str(fc4),'Hz']);
suptitle('Portadoras');

% Espectro de frequência das portadoras
t = 0:1/(fs):0.1;
vc12=amp*sin(2*pi*fc1*t);
vc22=amp*sin(2*pi*fc2*t);
vc32=amp*sin(2*pi*fc3*t);
vc42=amp*sin(2*pi*fc4*t);
figure(3);
FFT(vc12,fs);
hold on;
FFT(vc22,fs);
hold on;
FFT(vc32,fs);
hold on;
FFT(vc42,fs);
legend(['fc=',num2str(fc1,'%10.3e'),'Hz';'fc=',num2str(fc2,'%10.3e'),'Hz';'fc=',...
    num2str(fc3,'%10.3e'),'Hz';'fc=',num2str(fc4,'%10.3e'),'Hz']);

% Espectro de frequência da onda modulada
f_espec=max([fc1 fc2 fc3 fc4]);
figure(4);
[sig,f_1]=FFT(v,1/(2*T*Ts));
axis([0 2*f_espec 0 2*max(abs(sig))]);






