%%
clear all;
clc;

% Parâmetros
x=-25:0.1:25;% Vetor de posições em x
y=0:0.1:25; % Vetor de posições em y
h1=12;% Altura entre o condutor e a terra na letra a
h2=8.1;% Altura entre o condutor e a terra na letra b
h3=7.4;% Altura entre o condutor e a terra na letra c
x1=-25:1:25;
y1=0:1:25;
f=60;% Frequência de operação da rede
[X,Y]=meshgrid(x1,y1);

%-----------------------------------------------------------------
% Parâmetros dos fios originais

% Fio um
xl1=-8.4;% Posicao x
yl1=h1;% Posicao y

% Fio dois
xl2=0;% Posicao x
yl2=h1;% Posicao y

%Fio tres
xl3=8.4;% Posicao x
yl3=h1;% Posicao y

%------------------------------------------------------------
% Parâmetros das imagens

% Fio um
xl1i=xl1;
yl1i=-yl1;

% Fio dois
xl2i=xl2;
yl2i=-yl2;

% Fio três
xl3i=xl3;
yl3i=-yl3;

%% Cálculo dos campos elétricos
[Ea,Eb,Ec,Et1]=CalcE1(xl1,xl2,xl3,h1);% Utiliza a função para calcular os campos
                                      % eletricos em y=0
figure(1);
plot(x,abs(Ea));
title('Campo eletrico da linha A no solo para h=12m');
figure(2);
plot(x,abs(Eb));
title('Campo eletrico da linha B no solo para h=12m');
figure(3);
plot(x,abs(Ec));
title('Campo eletrico da linha C no solo para h=12m');
figure(4);
plot(x,abs(Et1));
title('Campo eletrico total no solo para h=12m');
%% Cálculo dos campos eletricos em qualquer parte da superfície
[Ext,Eyt]=CalcEq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i,h1);
figure(5);
quiver(X,Y,real(Ext)./abs(real(Ext)).*abs(Ext),real(Eyt)./abs(real(Eyt)).*abs(Eyt));
title('Campo eletrico total no plano');

%% Cáculo dos campos magnéticos no sólo
[Ba,Bb,Bc,Bt1]=CalcB1(xl1,xl2,xl3,h1);% Utiliza a função para calcular os campos 
                                      % magneticos em y=0
figure(6);
plot(x,abs(Ba));
title('Campo magnetico da linha A no solo para h=12m');
figure(7);
plot(x,abs(Bb));
title('Campo magnetico da linha B no solo para h=12m');
figure(8);
plot(x,abs(Bc));
title('Campo magnetico da linha C no solo para h=12m');
figure(9);
plot(x,abs(Bt1));
title('Campo magnetico total no solo para h=12m');

%% Cálculo dos campos magneticos em qualquer parte da superfície
[Bxt,Byt]=CalcBq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i);
figure(10);
quiver(X,Y,real(Bxt)./abs(real(Bxt)).*abs(Bxt),real(Byt)./abs(real(Byt)).*abs(Byt));
title('Campo magnetico total no plano');

%% Letra b
% Cálculo dos campos elétricos
[Ea,Eb,Ec,Et2]=CalcE1(xl1,xl2,xl3,h2);% Utiliza a função para calcular os campos
                                     % eletricos em y=0
figure(11);
plot(x,abs(Ea));
title('Campo eletrico da linha A no solo para h=8.1m');
figure(12);
plot(x,abs(Eb));
title('Campo eletrico da linha B no solo para h=8.1m');
figure(13);
plot(x,abs(Ec));
title('Campo eletrico da linha C no solo para h=8.1m');
figure(14);
plot(x,abs(Et2));
title('Campo eletrico total no solo para h=8.1m');

% Cálculo dos campos eletrico em qualquer parte da superfície
[Ext,Eyt]=CalcEq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i,h2);
figure(15);
quiver(X,Y,real(Ext)./abs(real(Ext)).*abs(Ext),real(Eyt)./abs(real(Eyt)).*abs(Eyt),1.5);
title('Campo eletrico total no plano');

% Cáculo dos campos magnéticos no sólo
[Ba,Bb,Bc,Bt2]=CalcB1(xl1,xl2,xl3,h2);% Utiliza a função para calcular os campos 
                                      % magneticos em y=0
figure(16);
plot(x,abs(Ba));
title('Campo magnetico da linha A no solo para h=8.1m');
figure(17);
plot(x,abs(Bb));
title('Campo magnetico da linha B no solo para h=8.1m');
figure(18);
plot(x,abs(Bc));
title('Campo magnetico da linha C no solo para h=8.1m');
figure(19);
plot(x,abs(Bt2));
title('Campo magnetico total no solo para h=8.1m');

% Cálculo dos campos magneticos em qualquer parte da superfície
[Bxt,Byt]=CalcBq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i);
figure(20);
quiver(X,Y,real(Bxt)./abs(real(Bxt)).*abs(Bxt),real(Byt)./abs(real(Byt)).*abs(Byt));
title('Campo magnetico total no plano');

%% Letra c
% Cálculo dos campos elétricos
[Ea,Eb,Ec,Et3]=CalcE1(xl1,xl2,xl3,h3);% Utiliza a função para calcular os campos
                                      % eletrico em y=0
figure(21);
plot(x,abs(Ea));
title('Campo eletrico da linha A no solo para h=7.4m');
figure(22);
plot(x,abs(Eb));
title('Campo eletrico da linha B no solo para h=7.4m');
figure(23);
plot(x,abs(Ec));
title('Campo eletrico da linha C no solo para h=7.4m');
figure(24);
plot(x,abs(Et3));
title('Campo eletrico total no solo para h=7.4m');

% Cálculo dos campos eletricos em qualquer parte da superfície
[Ext,Eyt]=CalcEq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i,h3);
figure(25);
quiver(X,Y,real(Ext)./abs(real(Ext)).*abs(Ext),real(Eyt)./abs(real(Eyt)).*abs(Eyt),1.5);
title('Campo eletrico total no plano');

% Cáculo dos campos magnéticos no sólo
[Ba,Bb,Bc,Bt3]=CalcB1(xl1,xl2,xl3,h3);% Utiliza a função para calcular os campos 
                                      % magneticos em y=0
figure(26);
plot(x,abs(Ba));
title('Campo magnetico da linha A no solo para h=7.4m');
figure(27);
plot(x,abs(Bb));
title('Campo magnetico da linha B no solo para h=7.4m');
figure(28);
plot(x,abs(Bc));
title('Campo magnetico da linha C no solo para h=7.4m');
figure(29);
plot(x,abs(Bt3));
title('Campo magnetico total no solo para h=7.4m');

% Cálculo dos campos magnetico em qualquer parte da superfície
[Bxt,Byt]=CalcBq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i);
figure(30);
quiver(X,Y,real(Bxt)./abs(real(Bxt)).*abs(Bxt),real(Byt)./abs(real(Byt)).*abs(Byt));
title('Campo magnetico total no plano');
%% Campos totais no solo
figure(31);
plot(x,abs(Et1));
hold on;
plot(x,abs(Et2));
hold on;
plot(x,abs(Et3));
title('Modulo dos campos eletricos totais para h diferentes');
legend('h=12m','h=8.1m','h=7.4m');
figure(32);
plot(x,abs(Bt1));
hold on;
plot(x,abs(Bt2));
hold on;
plot(x,abs(Bt3));
title('Modulo dos campos magneticos totais para h diferentes');
legend('h=12m','h=8.1m','h=7.4m');