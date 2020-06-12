function [Ea,Eb,Ec,Et] = CalcE1(xl1,xl2,xl3,h)
%Essa função calcula o campo elétrico em y=0

% Parâmetros
e0=1e-9/(36*pi);% Epsilon do vácuo
a=0.072;% Raio do cabo
VL=345e3;% Tensão de fase
fasep=-cos(pi/3)+1i*sin(pi/3);% Cálculo da fase positiva
fasen=-cos(pi/3)-1i*sin(pi/3);% Cálculo da fase negativa
x=-25:0.1:25;% Vetor de posições em x

% Definição das densidades de carga
VfA=VL/sqrt(3);
VfB=VL/sqrt(3)*fasen;
VfC=VL/sqrt(3)*fasep;
pLA=VfA*2*pi*e0/log(2*h/a);
pLB=VfB*2*pi*e0/log(2*h/a);
pLC=VfC*2*pi*e0/log(2*h/a);
% Cálculo dos campos elétricos no solo
for i=1:length(x)
    Ea(i)=-pLA*h/(pi*e0*((x(i)-xl1)^2+h^2));% Campo devido ao fio A em y=0
    Eb(i)=-pLB*h/(pi*e0*((x(i)-xl2)^2+h^2));% Campo devido ao fio B em y=0
    Ec(i)=-pLC*h/(pi*e0*((x(i)-xl3)^2+h^2));% Campo devido ao fio C em y=0
end
Et=Ea+Eb+Ec;% Campo eletrostático total em y=0
end

