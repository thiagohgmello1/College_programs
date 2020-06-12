%% Trabaho de eletromagnetismo
clear all;
clc;

% Definição dos parametros
delta=0.2;% Distancia entre dois nos
n=10000;% Numero de iteraçoes
L=20;% Comprimento dos lados em metro
nlc=L/delta;% Numero de linhas e colunas da matriz
V=zeros(nlc);% Cria a matriz de potenciais
fasep=-sin(pi/6)+1j*cos(pi/6);% Fase positiva
fasen=-sin(pi/6)-1j*cos(pi/6);% Fase negativa
v=345e3;% Tensao da linha
va=v;% Tensao na linha A
vb=v*fasep;% Tensao na linha B
vc=v*fasen;% Tensao na linha C
Ex=V;% Cria a matriz de campo elétrico em X
Ey=V;% Cria a matriz de campo elétrico em Y
Emax=8.33e3;% Campo eletrico maximo permitido no solo
Va=V;% Cria uma matriz para o salvamento do módulo do potencial
Exa=V;% Cria uma matriz para o salvamento do módulo do campo eletrico em x
Eya=V;% Cria uma matriz para o salvamento do módulo do campo eletrico em y
Pl=floor(12/delta);% Posiçao das linhas em y
Pcb=nlc/2-floor(1.5/delta);% Posição da linha 1 em x
Pca=nlc/2;% Posição da linha 2 em x
Pcc=nlc/2+floor(1.5/delta);% Posição da linha 3 em x
vet=1:nlc;% Cria um vetor para o eixo x dos gráficos
vet1=linspace(0,20,nlc);
[X,Y]=meshgrid(vet1,vet1);% Cria matrizes para o quiver e surf

%% Determinação do potencial

V(Pl,Pcb)=vb;% Determina o potencial na linha A nos pontos especificados
V(Pl,Pca)=va;% Determina o potencial na linha B nos pontos especificados
V(Pl,Pcc)=vc;% Determina o potencial na linha C nos pontos especificados
% Calcula os potenciais em todos os pontos da malha pelo método das
% diferenças finitas
for cont=1:n
    for i=2:nlc-1
        for j=2:nlc-1
            if ne(abs(V(i,j)),abs(va))
                V(i,j)=1/4*(V(i-1,j)+V(i+1,j)+V(i,j+1)+V(i,j-1));
            end
        end
    end
end

%% Determinação da intensidade de campo eletrico

% Calcula a intensidade do campo eletrico em toda a malha pelo método das
% diferenças finitas
for cont=1:n
    for i=2:nlc-1
        for j=1:nlc
            if j==1                               % Determina a componente x quando
                Ex(i,j)=1/delta*(V(i,j+1)-V(i,j));% está na primeira linha
            elseif j==nlc                           
                Ex(i,j)=1/delta*(V(i,j)-V(i,j-1));% Determina a componente x quando
                                                  % está em qualquer c
            else
                Ex(i,j)=1/(2*delta)*(V(i,j-1)-V(i,j+1));
            end
        end
    end
    for i=1:nlc
        for j=2:nlc-1
            if i==1
                Ey(i,j)=1/delta*(V(i+1,j)-V(i,j));
            elseif i==nlc
                Ey(i,j)=1/delta*(V(i,j)-V(i-1,j));
            else
                Ey(i,j)=1/(2*delta)*(V(i-1,j)-V(i+1,j));
            end
        end
    end
end

%% Determinação dos módulos das matrizes

for i=1:nlc
    for j=1:nlc
        Exa(i,j)=abs(Ex(i,j));% Calcula o módulo das componentes x da
                              % intensidade de campo eletrico
        Eya(i,j)=abs(Ey(i,j));% Calcula o módulo das componentes y da
                              % intensidade de campo eletrico
        Va(i,j)=abs(V(i,j));% Calcula o módulo do potencial
    end
end

%% Gráficos

figure(1);
plot(vet1,abs(Ex(nlc,:)));% Plota o módulo do campo na direção x em h=0
title('Grafico do campo eletrico no solo para h=12m na direcao x');
figure(2);
plot(vet1,abs(Ey(nlc,:)));% Plota o módulo do campo na direção y em h=0
title('Grafico do campo eletrico no solo para h=12m na direcao y');

%% Figuras tridimensionais

figure(3);
surf(Va);% Plota a superficie da distribuição de potencial
title('Modulo do potencial em toda a regiao');
figure(4);
surf(Exa);% Plota a superficie da distribuição de intenisdade de campo eletrico
          % em x
title('Modulo do campo eletrico em x em toda a regiao');
figure(5);
surf(Eya);% Plota a superficie da distribuição de intenisdade de campo eletrico
          % em y
title('modulo do campo eletrico em y em toda a regiao');

%% Mapa de contorno e vetores do campo elétrico
figure(6);
quiver(X,Y,real(Ex)./abs(real(Ex)).*abs(Ex),real(Ey)./abs(real(Ey)).*abs(Ey));
title('Vetores de campo eletrico na região especificada');
figure(7);
contourf(X,Y,Va,30);
colorbar();
%%
figure(8)
plot(vet1,Va(:,20));% Plota o módulo do campo na direção x em h=0

%%
Epx=Exa(floor(Pl/2),floor(Pcc-1.5/(2*delta)))
Epy=Eya(floor(Pl/2),floor(Pcc-1.5/(2*delta)))







