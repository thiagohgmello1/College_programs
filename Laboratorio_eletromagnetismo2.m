%% 
% Laboratório de eletromagnetismo
% Letra a

% Constantes elétricas e valores do exercício
roL=1;                                %Densidade linear de cargas do fio
E0=1e-9/(36*pi);                      %e0
k=roL/(4*pi*E0);
L=1;                                  %Comprimento do fio
xv=0.2;                               % Define um local para realizar o corte do plano yz
v=linspace(-1,1,20);                  %Cria um vetor igualmente espaçado
[Y1,Z1]=meshgrid(v);                  % Cria uma grade entre as matrizes Y1 e Z1
[X,Z,Y]=meshgrid(v);                  % Cria uma grade 3D entre as matrizes X, Y e Z
esp=10;                              % Calcula os espaçamentos do vetor para
                                      % o cálculo numérico
Xv=-0.5:1/esp:0.5;                    % Cria o vetor para o cálculo numérico
Ix=length(Xv);                        % Calcula o tamanho do vetor Xv
dx=1/esp;                             % Determina o delta x da integral numérica
xp=.2;                                % Determina o ponto x para o cálculo do campo
yp=.4;                                % Determina o ponto y para o cálculo do campo
zp=.3;                                % Determina o ponto z para o cálculo do campo
Xl=-0.5:0.01:0.5;
Yl=zeros(length(Xl));
Zl=Yl;

%Cálculo das integrais de linha para os vetores intensidade de campo elétrico

syms xl x y z ;                       %Cria as variaveis livres
fx=(x-xl)/(((x-xl)^2+y^2+z^2)^(3/2)); %Função do campo em x
Fx=int(fx,xl);                        %Calcula a integral indefinida em relação a xl
pretty(Fx);
fy=y/(((x-xl)^2+y^2+z^2)^(3/2));      %Função do campo em y
Fy=int(fy,xl);                        %Calcula a integral indefinida em relação a xl
pretty(Fy);
fz=z/(((x-xl)^2+y^2+z^2)^(3/2));      %Função do campo em z
Fz=int(fz,xl);                        %Calcula a integral indefinida em relação a xl
pretty(Fz);

%Expressão para os campos elétricos

Ex=k*(1./(sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -1./(sqrt((X+0.5).^2+Y.^2+Z.^2)));                       %Calcula o campo na direção
                                                             % x utilizando a integral indefinida Fx
Ey=-k*(Y.*(X-0.5)./((Y.^2+Z.^2).*sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -Y.*(X+0.5)./((Y.^2+Z.^2).*sqrt((X+0.5).^2+Y.^2+Z.^2))); %Calcula o campo na direção
                                                             % y utilizando a integral indefinida Fy
Ez=-k*(Z.*(X-0.5)./((Y.^2+Z.^2).*sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -Z.*(X+0.5)./((Y.^2+Z.^2).*sqrt((X+0.5).^2+Y.^2+Z.^2))); %Calcula o campo na direção
                                                             % z utilizando a integral indefinida Fz
figure(1);
quiver3(X,Z,Y,Ex,Ez,Ey); %Desenha o campo vetorial eletrostático
hold on;
plot3(Xl,Yl,Zl);

%%
Ex1=k*(1./(sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -1./(sqrt((xv+0.5).^2+Y1.^2+Z1.^2)));                       %Calcula o campo na direção
                                                             % x utilizando a integral indefinida Fx
Ey1=-k*(Y1.*(xv-0.5)./((Y1.^2+Z1.^2).*sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -Y1.*(xv+0.5)./((Y1.^2+Z1.^2).*sqrt((xv+0.5).^2+Y1.^2+Z1.^2))); %Calcula o campo na direção
                                                             % y utilizando a integral indefinida Fy
Ez1=-k*(Z1.*(xv-0.5)./((Y1.^2+Z1.^2).*sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -Z1.*(xv+0.5)./((Y1.^2+Z1.^2).*sqrt((xv+0.5).^2+Y1.^2+Z1.^2))); %Calcula o campo na direção
                                                             % z utilizando a integral indefinida Fz
Et=sqrt(Ex1^2+Ey1^2+Ez1^2);
figure(2);
mesh(Y1,Z1,Et);
colorbar();
figure(3);
contourf(Y1,Z1,Et);
colorbar()

%% 
%Letra b
f1=1/((x-xl)^2+y^2+z^2)^(1/2);
F1=int(f1);
pretty(F1);

%Expressão para os campos potenciais
%vp=linspace(-1,1,20); %Cria um vetor igualmente espaçado
V=-k*(log(X-0.5+sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -log(X+0.5+sqrt((X+0.5).^2+Y.^2+Z.^2)));  % Cálculo do potencial
V1=-k*(log(xv-0.5+sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...% Calcula o potencial em xv
    -log(xv+0.5+sqrt((xv+0.5).^2+Y1.^2+Z1.^2)));
figure(2);
mesh(Y1,Z1,V1);                               % Plota um desenho 3D do potencial
colorbar();                                   % Acrescenta a barra de cores
figure(3);
contourf(Y1,Z1,V1);                           % Cria um mapa de contorno
colorbar();                                   % Acrescenta a barra de cores 

%%
%Cálculo numérico

[Rnumx,Rnumy,Rnumz]=Int_num(xp,yp,zp,Xv);
Eanx=inline('1/(sqrt((x-0.5)^2+y^2+z^2))-1/(sqrt((x+0.5)^2+y^2+z^2))','x','y','z');
Ranx=k*Eanx(xp,yp,zp);
Eany=inline('y*(x-0.5)/((y^2+z^2)*sqrt((x-0.5)^2+y^2+z^2))-y*(x+0.5)/((y^2+z^2)*sqrt((x+0.5)^2+y^2+z^2))','x','y','z');
Rany=k*Eany(xp,yp,zp);
Eanz=inline('z*(x-0.5)/((y^2+z^2)*sqrt((x-0.5)^2+y^2+z^2))-z*(x+0.5)/((y^2+z^2)*sqrt((x+0.5)^2+y^2+z^2))','x','y','z');
Ranz=k*Eanz(xp,yp,zp);
Etan=sqrt(Ranx^2+Rany^2+Ranz^2);
Etnum=k*sqrt(Rnumx^2+Rnumy^2+Rnumz^2);

%%
%Cálculo dos erros percentiais relativos

Errop=abs(Etan-Etnum)*100/Etnum; %Calcula o erro percentual relativo entre o campo total
                                 % pela solução analitica e pela solução numérica




