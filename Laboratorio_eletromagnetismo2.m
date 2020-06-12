%% 
% Laborat�rio de eletromagnetismo
% Letra a

% Constantes el�tricas e valores do exerc�cio
roL=1;                                %Densidade linear de cargas do fio
E0=1e-9/(36*pi);                      %e0
k=roL/(4*pi*E0);
L=1;                                  %Comprimento do fio
xv=0.2;                               % Define um local para realizar o corte do plano yz
v=linspace(-1,1,20);                  %Cria um vetor igualmente espa�ado
[Y1,Z1]=meshgrid(v);                  % Cria uma grade entre as matrizes Y1 e Z1
[X,Z,Y]=meshgrid(v);                  % Cria uma grade 3D entre as matrizes X, Y e Z
esp=10;                              % Calcula os espa�amentos do vetor para
                                      % o c�lculo num�rico
Xv=-0.5:1/esp:0.5;                    % Cria o vetor para o c�lculo num�rico
Ix=length(Xv);                        % Calcula o tamanho do vetor Xv
dx=1/esp;                             % Determina o delta x da integral num�rica
xp=.2;                                % Determina o ponto x para o c�lculo do campo
yp=.4;                                % Determina o ponto y para o c�lculo do campo
zp=.3;                                % Determina o ponto z para o c�lculo do campo
Xl=-0.5:0.01:0.5;
Yl=zeros(length(Xl));
Zl=Yl;

%C�lculo das integrais de linha para os vetores intensidade de campo el�trico

syms xl x y z ;                       %Cria as variaveis livres
fx=(x-xl)/(((x-xl)^2+y^2+z^2)^(3/2)); %Fun��o do campo em x
Fx=int(fx,xl);                        %Calcula a integral indefinida em rela��o a xl
pretty(Fx);
fy=y/(((x-xl)^2+y^2+z^2)^(3/2));      %Fun��o do campo em y
Fy=int(fy,xl);                        %Calcula a integral indefinida em rela��o a xl
pretty(Fy);
fz=z/(((x-xl)^2+y^2+z^2)^(3/2));      %Fun��o do campo em z
Fz=int(fz,xl);                        %Calcula a integral indefinida em rela��o a xl
pretty(Fz);

%Express�o para os campos el�tricos

Ex=k*(1./(sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -1./(sqrt((X+0.5).^2+Y.^2+Z.^2)));                       %Calcula o campo na dire��o
                                                             % x utilizando a integral indefinida Fx
Ey=-k*(Y.*(X-0.5)./((Y.^2+Z.^2).*sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -Y.*(X+0.5)./((Y.^2+Z.^2).*sqrt((X+0.5).^2+Y.^2+Z.^2))); %Calcula o campo na dire��o
                                                             % y utilizando a integral indefinida Fy
Ez=-k*(Z.*(X-0.5)./((Y.^2+Z.^2).*sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -Z.*(X+0.5)./((Y.^2+Z.^2).*sqrt((X+0.5).^2+Y.^2+Z.^2))); %Calcula o campo na dire��o
                                                             % z utilizando a integral indefinida Fz
figure(1);
quiver3(X,Z,Y,Ex,Ez,Ey); %Desenha o campo vetorial eletrost�tico
hold on;
plot3(Xl,Yl,Zl);

%%
Ex1=k*(1./(sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -1./(sqrt((xv+0.5).^2+Y1.^2+Z1.^2)));                       %Calcula o campo na dire��o
                                                             % x utilizando a integral indefinida Fx
Ey1=-k*(Y1.*(xv-0.5)./((Y1.^2+Z1.^2).*sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -Y1.*(xv+0.5)./((Y1.^2+Z1.^2).*sqrt((xv+0.5).^2+Y1.^2+Z1.^2))); %Calcula o campo na dire��o
                                                             % y utilizando a integral indefinida Fy
Ez1=-k*(Z1.*(xv-0.5)./((Y1.^2+Z1.^2).*sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...
    -Z1.*(xv+0.5)./((Y1.^2+Z1.^2).*sqrt((xv+0.5).^2+Y1.^2+Z1.^2))); %Calcula o campo na dire��o
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

%Express�o para os campos potenciais
%vp=linspace(-1,1,20); %Cria um vetor igualmente espa�ado
V=-k*(log(X-0.5+sqrt((X-0.5).^2+Y.^2+Z.^2))...
    -log(X+0.5+sqrt((X+0.5).^2+Y.^2+Z.^2)));  % C�lculo do potencial
V1=-k*(log(xv-0.5+sqrt((xv-0.5).^2+Y1.^2+Z1.^2))...% Calcula o potencial em xv
    -log(xv+0.5+sqrt((xv+0.5).^2+Y1.^2+Z1.^2)));
figure(2);
mesh(Y1,Z1,V1);                               % Plota um desenho 3D do potencial
colorbar();                                   % Acrescenta a barra de cores
figure(3);
contourf(Y1,Z1,V1);                           % Cria um mapa de contorno
colorbar();                                   % Acrescenta a barra de cores 

%%
%C�lculo num�rico

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
%C�lculo dos erros percentiais relativos

Errop=abs(Etan-Etnum)*100/Etnum; %Calcula o erro percentual relativo entre o campo total
                                 % pela solu��o analitica e pela solu��o num�rica




