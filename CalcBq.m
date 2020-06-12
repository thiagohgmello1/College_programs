function [Bxt,Byt] = CalcBq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i)
%calcula o campo magnetsotático em qualquer ponto da superfície

% Parâmetros
mi=4e-7*pi;% Mi do vácuo
S=1090e6;% Potência aparente
VL=345e3;% Tensão de fase
fasep=-cos(pi/3)+1i*sin(pi/3);% Cálculo da fase positiva
fasen=-cos(pi/3)-1i*sin(pi/3);% Cálculo da fase negativa
x1=-25:1:25;
y1=0:1:25;
[X,Y]=meshgrid(x1,y1);

% Cálculo das correntes
IL=S/(sqrt(3)*VL);% Corrente de linha
ILA=IL;% Corrente de linha para a fase A
ILB=IL*fasen;% Corrente de linha para a fase B
ILC=IL*fasep;% Corrente de linha para a fase C

% Fios originais
B1x=-mi*ILA*(Y-yl1)./(2*pi*((X-xl1).^2+(Y-yl1).^2));
B1y=mi*ILA*(X-xl1)./(2*pi*((X-xl1).^2+(Y-yl1).^2));
B2x=-mi*ILB*(Y-yl2)./(2*pi*((X-xl2).^2+(Y-yl2).^2));
B2y=mi*ILB*(X-xl2)./(2*pi*((X-xl2).^2+(Y-yl2).^2));
B3x=-mi*ILC*(Y-yl3)./(2*pi*((X-xl3).^2+(Y-yl3).^2));
B3y=mi*ILC*(X-xl3)./(2*pi*((X-xl3).^2+(Y-yl3).^2));

% Fios imagens
B1ix=mi*ILA*(Y-yl1i)./(2*pi*((X-xl1i).^2+(Y-yl1i).^2));
B1iy=-mi*ILA*(X-xl1i)./(2*pi*((X-xl1i).^2+(Y-yl1i).^2));
B2ix=mi*ILB*(Y-yl2i)./(2*pi*((X-xl2i).^2+(Y-yl2i).^2));
B2iy=-mi*ILB*(X-xl2i)./(2*pi*((X-xl2i).^2+(Y-yl2i).^2));
B3ix=mi*ILC*(Y-yl3i)./(2*pi*((X-xl3i).^2+(Y-yl3i).^2));
B3iy=-mi*ILC*(X-xl3i)./(2*pi*((X-xl3i).^2+(Y-yl3i).^2));
Bxt=B1x+B2x+B3x+B1ix+B2ix+B3ix;% Campo magnetostático total em x
Byt=B1y+B2y+B3y+B1iy+B2iy+B3iy;% Campo magnetostático total em y
end

