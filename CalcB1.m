function [Ba,Bb,Bc,Bt] = CalcB1(xl1,xl2,xl3,h)
%Calcula o campo magnetostático em y=0

% Parâmetros
mi=4e-7*pi;% Mi do vácuo
S=1090e6;% Potência aparente
VL=345e3;% Tensão de fase
fasep=-cos(pi/3)+1i*sin(pi/3);% Cálculo da fase positiva
fasen=-cos(pi/3)-1i*sin(pi/3);% Cálculo da fase negativa
x=-25:0.1:25;% Vetor de posições em x
IL=S/(sqrt(3)*VL);% Corrente de linha
ILA=IL;% Corrente de linha para a fase A
ILB=IL*fasen;% Corrente de linha para a fase B
ILC=IL*fasep;% Corrente de linha para a fase C

for i=1:length(x)
    Ba(i)=mi*ILA*h/(pi*((x(i)-xl1)^2+h^2));% Campo magnetostático devido ao fio A
    Bb(i)=mi*ILB*h/(pi*((x(i)-xl2)^2+h^2));% Campo magnetostático devido ao fio B
    Bc(i)=mi*ILC*h/(pi*((x(i)-xl3)^2+h^2));% Campo magnetostático devido ao fio C
end
Bt=Ba+Bb+Bc;% Campo magnetostático total
end

