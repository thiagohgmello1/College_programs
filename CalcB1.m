function [Ba,Bb,Bc,Bt] = CalcB1(xl1,xl2,xl3,h)
%Calcula o campo magnetost�tico em y=0

% Par�metros
mi=4e-7*pi;% Mi do v�cuo
S=1090e6;% Pot�ncia aparente
VL=345e3;% Tens�o de fase
fasep=-cos(pi/3)+1i*sin(pi/3);% C�lculo da fase positiva
fasen=-cos(pi/3)-1i*sin(pi/3);% C�lculo da fase negativa
x=-25:0.1:25;% Vetor de posi��es em x
IL=S/(sqrt(3)*VL);% Corrente de linha
ILA=IL;% Corrente de linha para a fase A
ILB=IL*fasen;% Corrente de linha para a fase B
ILC=IL*fasep;% Corrente de linha para a fase C

for i=1:length(x)
    Ba(i)=mi*ILA*h/(pi*((x(i)-xl1)^2+h^2));% Campo magnetost�tico devido ao fio A
    Bb(i)=mi*ILB*h/(pi*((x(i)-xl2)^2+h^2));% Campo magnetost�tico devido ao fio B
    Bc(i)=mi*ILC*h/(pi*((x(i)-xl3)^2+h^2));% Campo magnetost�tico devido ao fio C
end
Bt=Ba+Bb+Bc;% Campo magnetost�tico total
end

