%% Trabalho de irradiação e ondas guiadas
% Alunos: Thiago Henrique Gonçalves Mello e Daniel de Sá Araújo

clc;
clear all;
close all;

%Parâmetros
% Frequência (Hz), potência (W), número de iterações e o tamanho dos
% intervalos (m)
f=870e6;
w=2*pi*f;
P=0.6;
n=100;
deltaL=1e-3;

% Permissividades e permeabilidades
ep0=1e-9/(36*pi); % epsilon zero
mi0=4e-7*pi; % mi zero
er_ar=1; % Ar
er_pele=41.4; % Pele
er_gordura=11.3; % Gordura
er_cranio=17.4; % Cranio
er_cerebro=49.6; % Cerebro
er_hipofise=45.26; % Hipófise

% Condutividades elétricas (S/m)
s_ar=0; % Ar
s_pele=0.87; % Pele
s_gordura=0.11; % Gordura
s_cranio=0.25; % Crânio
s_cerebro=1.03; % Cérebro
s_hipofise=0.92; % Hipófise

% Epsilon complexo (F/m)
epi_ar=ep0*er_ar-1j*s_ar/w;
epi_pele=ep0*er_pele-1j*s_pele/w;
epi_gordura=ep0*er_gordura-1j*s_gordura/w;
epi_cranio=ep0*er_cranio-1j*s_cranio/w;
epi_cerebro=ep0*er_cerebro-1j*s_cerebro/w;
epi_hipofise=ep0*er_hipofise-1j*s_hipofise/w;

% Densidades (Kg/m3)
ro_pele=1010; % Pele
ro_gordura=940; % Gordura
ro_cranio=1200; % Crânio
ro_cerebro=1060; % Cérebro
ro_hipofise=1040; % Hipófise

% Espessuras (m)
L_pele=2e-3; % Pele
L_gordura=4e-3; % Gordura
L_cranio=10e-3; % Crânio
L_cerebro=100e-3; % Cérebro
L_hipofise=2e-3; % Hipófise
L_total=L_pele+L_gordura+L_cranio+L_cerebro+L_hipofise;

x=[0 L_pele, L_gordura+L_pele, L_gordura+L_pele+L_cranio, L_gordura+L_pele+L_cranio+L_cerebro,...
   L_total+L_hipofise, L_total+L_hipofise+L_cerebro, L_total+L_hipofise+L_cerebro+L_cranio,...
   L_total+L_hipofise+L_cerebro+L_cranio+L_gordura, 2*L_total];


%% Determinação das impedâncias intrínsecas

eta_ar=sqrt(mi0/ep0);
eta_pele=sqrt((1j*w*mi0)/(s_pele+1j*w*ep0*er_pele));
eta_gordura=sqrt((1j*w*mi0)/(s_gordura+1j*w*ep0*er_gordura));
eta_cranio=sqrt((1j*w*mi0)/(s_cranio+1j*w*ep0*er_cranio));
eta_cerebro=sqrt((1j*w*mi0)/(s_cerebro+1j*w*ep0*er_cerebro));
eta_hipofise=sqrt((1j*w*mi0)/(s_hipofise+1j*w*ep0*er_hipofise));

% Determinação das constantes de propagação
k_ar=w*sqrt(mi0*epi_ar);
k_pele=w*sqrt(mi0*epi_pele);
k_gordura=w*sqrt(mi0*epi_gordura);
k_cranio=w*sqrt(mi0*epi_cranio);
k_cerebro=w*sqrt(mi0*epi_cerebro);
k_hipofise=w*sqrt(mi0*epi_hipofise);

%% Coeficientes de reflexão e transmissão

% Reflexão
Gama_ar_pele=(eta_pele-eta_ar)/(eta_pele+eta_ar);
Gama_pele_gordura=(eta_gordura-eta_pele)/(eta_pele+eta_gordura);
Gama_gordura_cranio=(eta_cranio-eta_gordura)/(eta_cranio+eta_gordura);
Gama_cranio_cerebro=(eta_cerebro-eta_cranio)/(eta_cranio+eta_cerebro);
Gama_cerebro_hipofise=(eta_hipofise-eta_cerebro)/(eta_hipofise+eta_cerebro);
Gama=[Gama_ar_pele Gama_pele_gordura Gama_gordura_cranio Gama_cranio_cerebro ...
     Gama_cerebro_hipofise -1*Gama_cerebro_hipofise -1*Gama_cranio_cerebro ...
     -1*Gama_gordura_cranio -1*Gama_pele_gordura -1*Gama_ar_pele];

% Transmissão
tal_ar_pele=1+Gama_ar_pele;
tal_pele_gordura=1+Gama_pele_gordura;
tal_gordura_cranio=1+Gama_gordura_cranio;
tal_cranio_cerebro=1+Gama_cranio_cerebro;
tal_cerebro_hipofise=1+Gama_cerebro_hipofise;
tal=[1+Gama(1) 1+Gama(2) 1+Gama(3) 1+Gama(4) 1+Gama(5) 1+Gama(6) 1+Gama(7) ...
    1+Gama(8) 1+Gama(9) 1+Gama(10)];

%Campo elétrico máximo no ar (V/m)
Emax=sqrt(2*P*eta_ar)*exp(1j*pi/2);

%% Rotina para determinação dos vetores

d=deltaL:deltaL:2*L_total; % Vetor posição
Etotal=zeros(1,length(d)); % Campo elétrico total em cada posição
Eref1=zeros(1,length(d)); % Campo elétrico total no sentido negativo
Eref2=zeros(1,length(d)); % Campo elétrico total no sentido negativo
Etran1=zeros(1,length(d)+1); % Campo elétrico total no sentido positivo
Etran2=zeros(1,length(d)); % Campo elétrico total no sentido negativo
k=zeros(1,length(d)); % Vetor de número de onda e constante de perdas
s=zeros(1,length(d)); % Vetor de condutividade
ro=zeros(1,length(d)); % Vetor de densidade
Gamat=zeros(1,length(d)); % Coeficiente de reflexão no sentido positivo
talt=zeros(1,length(d)); % Coeficiente de transmissão no sentido positivo
Etran1(1)=Emax*exp(-k_ar*10*d(1)*1j);
r=zeros(1,length(d));

for i=1:length(d)
    Gamat(i)=0;
    talt(i)=1;
    if i<=x(2)/deltaL
        k(i)=k_pele;
        s(i)=s_pele;
        ro(i)=ro_pele;
        r(i)=d(i)-x(1);
    elseif i<=x(3)/deltaL
        k(i)=k_gordura;
        s(i)=s_gordura;
        ro(i)=ro_gordura;
        r(i)=d(i)-x(2);
    elseif i<=x(4)/deltaL
        k(i)=k_cranio;
        s(i)=s_cranio;
        ro(i)=ro_cranio;
        r(i)=d(i)-x(3);
    elseif i<=x(5)/deltaL
        k(i)=k_cerebro;
        s(i)=s_cerebro;
        ro(i)=ro_cerebro;
        r(i)=d(i)-x(4);
    elseif i<=x(6)/deltaL
        k(i)=k_hipofise;
        s(i)=s_hipofise;
        ro(i)=ro_hipofise;
        r(i)=d(i)-x(5);
    elseif i<=x(7)/deltaL
        k(i)=k_cerebro;
        s(i)=s_cerebro;
        ro(i)=ro_cerebro;
        r(i)=d(i)-x(6);
    elseif i<=x(8)/deltaL
        k(i)=k_cranio;
        s(i)=s_cranio;
        ro(i)=ro_cranio;
        r(i)=d(i)-x(7);
    elseif i<=x(9)/deltaL
        k(i)=k_gordura;
        s(i)=s_gordura;
        ro(i)=ro_gordura;
        r(i)=d(i)-x(8);
    else
        k(i)=k_pele;
        s(i)=s_pele;
        ro(i)=ro_pele;
        r(i)=d(i)-x(9);
    end
end

for j=1:10
    aux=int16(1+x(j)/deltaL);
    talt(aux)=tal(j);
end

for j=2:10
    aux=int16(x(j)/deltaL);
    Gamat(aux)=Gama(j);
end

%% Rotina para determinação do campo elétrico

for i=1:n
    if i==1
        for j=1:length(d)
            Etran1(j+1)=talt(j)*Etran1(j)*exp(-1j*k(j)*r(j));
            Eref1(j)=Gamat(j)*Etran1(j+1)*exp(1j*k(j)*r(j));
            Etotal(j)=Etotal(j)+Etran1(j+1);
        end
    else
        for j=2:length(d)
            Etran1(j+1)=talt(j)*Etran1(j)*exp(-1j*k(j)*r(j))+Etran1(j+1);
            Eref1(j)=Gamat(j)*Etran1(j+1)*exp(-1j*k(j)*r(j));
            Etotal(j-1)=Etotal(j-1)+Etran1(j);
        end
    end
    Etran1(2);
    for j=1:length(d)
        cont=length(d)-j+2;
        if j==1
            Etran2(j)=Eref1(cont-1);
            Etotal(cont-1)=Etotal(cont-1)+Etran2(j);
        else
            Etran2(j)=talt(j)*Etran2(j-1)*exp(1j*k(j)*r(cont))+Eref1(cont-1);
            Etotal(cont-1)=Etotal(cont-1)+Etran2(j);
        end
    end
    for j=1:length(d)
        cont=length(d)-j+1;
        Eref2(j)=Gamat(j)*Etran2(j)*exp(r(cont)*r(cont));
        Etran1(cont+1)=Eref2(j);
    end
end

%% Taxa de absorção específica

SAR=1/2*(s.*abs(Etotal).^2)./ro;

%% Gráficos

figure(1);
plot(1000*d,abs(Etotal));
title('Módulo do campo elétrico nas diversas interfaces')
xlabel('z(mm)');
ylabel('|E|(V/m)');
figure(2);
plot(1000*d,abs(SAR));
title('SAR');
xlabel('z(mm)');
ylabel('|SAR|(W/Kg)');




