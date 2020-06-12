%%
clear all;
clc;

%Constantes
e0=1e-9/(36*pi); % e0
k=1/(4*pi*e0);

%Valores do exerc�cio
q1=-1e-9; % Carga um
q2=1e-9; % Carga dois
Vp=linspace(-0.9,0.9,100); % Vetor posi��o
p1=-0.6; % Posicao da carga q1
p2=0.6; % Posicao da carga q2

%C�lculos dos campos
R1=Vp-p1; % Vetor distancia entre o ponto e a carga q1
R2=Vp-p2; % Vetor distancia entre o ponto e a carga q2
E1=(k*q1.*R1./sqrt(R1.^2).^3); % Campo eletrostatico no ponto causado por q1
E2=(k*q2.*R2./sqrt(R2.^2).^3); % campo eletrostatico no ponto causado por q2
Et=E1+E2; % Campo total

%Gr�fico
figure(1)
plot(Vp,Et);
title('Campo eletrostatico para cargas de sinais opostos');
%%

%Par�metros
esp=0.1; % Espa�amento entre os numeros do vetor VP

%C�lculos
VP=-0.9:esp:0.9; % Vetor posi��o para o campo vetorial
[X,Y]=meshgrid(VP); % Cria duas matrizes nxn
r1=sqrt((X-p1).^2+Y.^2);% Calcula o denominador da equacao 1
r2=sqrt((X+p1).^2+Y.^2);% Calcula o denominador da equacao 2
Ex=k*q1*(X-p1)./(r1.^3)+k*q2*(X+p1)./(r2.^3); % Equacao do campo no eixo x
Ey=k*q1*Y./(r1.^3)+k*q2*Y./(r2.^3);% Equacao do campo no eixo y

%Gr�fico do campo vetorial eletrost�tico
figure(2)
quiver(X,Y,Ex,Ey);% Plota o campo vetorial eletrostatico
title('Campo vetorial eletrostatico');
xlabel('Distancia x (m)');
ylabel('Distancia y (m)');
%%

E=sqrt(Ex.^2+Ey.^2);% Define o m�dulo do campo eletrost�tico
contourf(X,Y,E);% Desenha um gr�fico de contorno do campo eletrost�tico
title('Mapa de contorno do campo eletrostatico')
colorbar();
%%

%Valores das cargas
q12=1e-9;
q22=1e-9;

%C�lculos dos campos
E12=(k*q12.*R1./sqrt(R1.^2).^3); % Campo eletrostatico no ponto causado por q1
E22=(k*q22.*R2./sqrt(R2.^2).^3); % campo eletrostatico no ponto causado por q2
Et2=E12+E22; % Campo total

%Gr�fico
figure(3)
plot(Vp,Et2);
title('Campo eletrostatico para duas cargas positivas');
xlabel('Distancia x (m)');
ylabel('Distancia y (m)');

%C�lculos dos campos vetoriais para duas cargas positivas
Ex2=k*q12*(X-p1)./(r1.^3)+k*q22*(X+p1)./(r2.^3); % Equacao do campo no eixo x
Ey2=k*q12*Y./(r1.^3)+k*q22*Y./(r2.^3);% Equacao do campo no eixo y

%Gr�fico do campo vetorial eletrost�tico
figure(4)
quiver(X,Y,Ex2,Ey2);% Plota o campo vetorial eletrostatico
title('Campo vetorial eletrostatico para duas cargas positivas')
xlabel('Distancia x (m)');
ylabel('Distancia y (m)');


%%

%Determina��o das cargas
%Carga 1:
Q1=1e-9;
xl1=0.3;
yl1=0.3;
zl1=0;

%Carga 2:
Q2=-1e-9;
xl2=-0.3;
yl2=0.3;
zl2=0;

%Carga 3:
Q3=1e-9;
xl3=-0.3;
yl3=-0.3;
zl3=0;

%Carga 4:
Q4=-1e-9;
xl4=0.3;
yl4=-0.3;
zl4=0;

%Determina��o dos c�lculos
V=linspace(-0.9,0.9,10); %Cria um vetor espa�ado igualmente
[X1,Y1,Z1]=meshgrid(V); % Cria 3 matrizes tridimensionais
vd1=sqrt((X1-xl1).^2+(Y1-yl1).^2+(Z1-zl1).^2); % M�dulo do vetor dist�ncia
vd2=sqrt((X1-xl2).^2+(Y1-yl2).^2+(Z1-zl2).^2); % M�dulo do vetor dist�ncia
vd3=sqrt((X1-xl3).^2+(Y1-yl3).^2+(Z1-zl3).^2); % M�dulo do vetor dist�ncia
vd4=sqrt((X1-xl4).^2+(Y1-yl4).^2+(Z1-zl4).^2); % M�dulo do vetor dist�ncia
Ex1=k*Q1*(X1-xl1)./(vd1.^3); % Campo vetorial da carga 1 em x
Ey1=k*Q1*(Y1-yl1)./(vd1.^3); % Campo vetorial da carga 1 em y
Ez1=k*Q1*(Z1-zl1)./(vd1.^3); % Campo vetorial da carga 1 em z
Ex2=k*Q1*(X1-xl2)./(vd2.^3); % Campo vetorial da carga 2 em x
Ey2=k*Q1*(Y1-yl2)./(vd2.^3); % Campo vetorial da carga 2 em y
Ez2=k*Q1*(Z1-zl2)./(vd2.^3); % Campo vetorial da carga 2 em z
Ex3=k*Q1*(X1-xl3)./(vd3.^3); % Campo vetorial da carga 3 em x
Ey3=k*Q1*(Y1-yl3)./(vd3.^3); % Campo vetorial da carga 3 em y
Ez3=k*Q1*(Z1-zl3)./(vd3.^3); % Campo vetorial da carga 3 em z
Ex4=k*Q1*(X1-xl4)./(vd4.^3); % Campo vetorial da carga 4 em x
Ey4=k*Q1*(Y1-yl4)./(vd4.^3); % Campo vetorial da carga 4 em y
Ez4=k*Q1*(Z1-zl4)./(vd4.^3); % Campo vetorial da carga 4 em z
Ext=Ex1+Ex2+Ex3+Ex4; % Campo vetorial resultante em x
Eyt=Ey1+Ey2+Ey3+Ey4; % Campo vetorial resultante em y
Ezt=Ez1+Ez2+Ez3+Ez4; % Campo vetorial resultante em z
quiver3(X1,Y1,Z1,Ext,Eyt,Ezt); % Plota os campos vetoriais
hold on
plot3(0.3,0.3,0,'.b',0.3,-0.3,0,'.b',-0.3,0.3,0,'.b',-0.3,-0.3,0,'.b'); % Plota os pontos
title('Campo vetorial eletrostatico para distribuicao de quatro cargas');
xlabel('Distancia x (m)');
ylabel('Distancia y (m)');
zlabel('Distancia z (m)');