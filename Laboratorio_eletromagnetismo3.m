%% laborat�rio de eletromagnetismo- Pr�tica 4
clear all;

% Definir as dimens�es da placa e as constantes

Lx=152.5e-3;% Comprimento da placa em x
Ly=200e-3;% Comprimento da placa em y
e=1e-9/(36*pi);% Epsilon do v�cuo
er=4.3;% Epsilon relativo
n=8;% N�mero de intervalos que as placas v�o ser divididas em uma dire��o
d=1.53e-3;% Dist�ncia entre as placas
V1=1;% Potencial da placa superior
V2=-1;% Potencial da placa inferior
deltaLx=Lx/n;% Define o deltaL para o c�lculo da carga
deltaLy=Ly/n;% Define o deltaL para o c�lculo da carga
A=Lx^2/(n^2);% Calcula a �rea de cada elemento da placa
div=n^2;

%---------------------------------------------------------------------

%Defini��o dos vetores posi��o

for j=1:2*n% Calcula a posi��o x de cada elemento das placas
    for i=1:n
        iaux=i+n*(j-1);
        if j<=n
            Px(iaux)=Lx/n*(j-1/2);
        else
            Px(iaux)=Lx/n*(j-n-1/2);
        end
    end
end
for j=1:2*n% Calcula a posi��o y de cada elemento das placas
    for i=1:n
        iaux=i+n*(j-1);
        Py(iaux)=Ly/n*(i-1/2);
        Vpot(iaux)=V1;% Calcula o vetor de potencial
    end
end
for j=1:div% Calcula a posi��o y de cada elemento das placas
    Vpot(j)=1;
    Vpot(j+div)=-1;
end

%----------------------------------------------------------------------

% Defini��o do vetor dist�ncia

for i=1:2*div% Calcula o vetor dist�ncia
    for j=1:2*div
        if i<=div
            if j<=div
                Ra(i,j)=sqrt((Px(i)-Px(j))^2+(Py(i)-Py(j))^2);
            else
                Ra(i,j)=sqrt((Px(i)-Px(j))^2+(Py(i)-Py(j))^2+d^2);
            end
        else
            if j<=div
                Ra(i,j)=sqrt((Px(i)-Px(j))^2+(Py(i)-Py(j))^2+d^2);
            else
                Ra(i,j)=sqrt((Px(i)-Px(j))^2+(Py(i)-Py(j))^2);
            end
        end
    end
end
for i=1:2*div% Calcula a matriz com as aproxima��es para cada potencial
    for j=1:2*div
        if i==j
            Z(i,j)=(deltaLx*log(1+sqrt(2)))/(pi*e*er);
        else
            Z(i,j)=deltaLx^2/(4*pi*er*e*Ra(i,j));
        end
    end
end
ro=Vpot/Z;% Cria um vetor com a distribui��o de carga para cada divis�o
% for j=1:ny
%     for i=1:nx% Cria uma matriz com os elementos da densidade de carga para
%               % a posi��o x e posi��o y
%         iaux=i+nx*(j-1);
%         Ro(j,i)=ro(iaux);
%         X(j,i)=Px(iaux);
%         Y(j,i)=Py(iaux);
%     end
% end
% mesh(X,Y,Ro);
q=0;
for i=1:div
    q=q+ro(i);
end
C=abs(q)*A/2;% Capacit�ncia do capacitor de placas paralelas