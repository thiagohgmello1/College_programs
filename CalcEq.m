function [Ext,Eyt] = CalcEq(xl1,yl1,xl2,yl2,xl3,yl3,xl1i,yl1i,xl2i,yl2i,xl3i,yl3i,h)
%Calcula os campos eletrost�ticos totais para qualquer ponto da superf�cie
% Par�metros
e0=1e-9/(36*pi);% Epsilon do v�cuo
a=0.072;% Raio do cabo
VL=345e3;% Tens�o de fase
fasep=-cos(pi/3)+1i*sin(pi/3);% C�lculo da fase positiva
fasen=-cos(pi/3)-1i*sin(pi/3);% C�lculo da fase negativa
x1=-25:1:25;
y1=0:1:25;
[X,Y]=meshgrid(x1,y1);

% Defini��o das densidades de carga
VfA=VL/sqrt(3);
VfB=VL/sqrt(3)*fasen;
VfC=VL/sqrt(3)*fasep;
pLA=VfA*2*pi*e0/log(2*h/a);
pLB=VfB*2*pi*e0/log(2*h/a);
pLC=VfC*2*pi*e0/log(2*h/a);
% Fios originais
% Fio um
Eaox=pLA*(X-xl1)./(pi*e0*((X-xl1).^2+(Y-yl1).^2));% Campo eletrost�tico
                                                  % do fio A em x
Eaoy=pLA*(Y-yl1)./(pi*e0*((X-xl1).^2+(Y-yl1).^2));% Campo eletrost�tico
                                                  % do fio A em y
% Fio dois
Ebox=pLB*(X-xl2)./(pi*e0*((X-xl2).^2+(Y-yl2).^2));% Campo eletrost�tico
                                                  % do fio B em x
Eboy=pLB*(Y-yl2)./(pi*e0*((X-xl2).^2+(Y-yl2).^2));% Campo eletrost�tico
                                                  % do fio B em Y
% Fio tr�s
Ecox=pLC*(X-xl3)./(pi*e0*((X-xl3).^2+(Y-yl3).^2));% Campo eletrost�tico
                                                  % do fio C em x
Ecoy=pLC*(Y-yl3)./(pi*e0*((X-xl3).^2+(Y-yl3).^2));% Campo eletrost�tico
                                                  % do fio C em y
% Fios imagens
% Fio um
Eaix=-pLA*(X-xl1i)./(pi*e0*((X-xl1i).^2+(Y-yl1i).^2));% Campo eletrost�tico
                                                     % do fio A em x
Eaiy=-pLA*(Y-yl1i)./(pi*e0*((X-xl1i).^2+(Y-yl1i).^2));% Campo eletrost�tico
                                                     % do fio A em y
% Fio dois
Ebix=-pLB*(X-xl2i)./(pi*e0*((X-xl2i).^2+(Y-yl2i).^2));% Campo eletrost�tico
                                                     % do fio B em x
Ebiy=-pLB*(Y-yl2i)./(pi*e0*((X-xl2i).^2+(Y-yl2i).^2));% Campo eletrost�tico
                                                     % do fio B em Y
% Fio tr�s
Ecix=-pLC*(X-xl3i)./(pi*e0*((X-xl3i).^2+(Y-yl3i).^2));% Campo eletrost�tico
                                                     % do fio C em x
Eciy=-pLC*(Y-yl3i)./(pi*e0*((X-xl3i).^2+(Y-yl3i).^2));% Campo eletrost�tico
                                                     % do fio C em y
Ext=Eaox+Eaix+Ebox+Ebix+Ecox+Ecix;
Eyt=Eaoy+Eaiy+Eboy+Ebiy+Ecoy+Eciy;
end

