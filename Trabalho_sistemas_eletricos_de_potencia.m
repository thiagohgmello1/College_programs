%% Trabalho de sistemas el�tricos de pot�ncia
% Alunos: Daniel de S� Ara�jo, M�rcio Luiz Pinto da Silva J�nior, Mariana
% Christina Silva Perp�tuo e Thiago Hnerique G. Mello
% Professora: Patr�cia Romeiro da Silva Jota
%
% Etapa 1 - Programa para determina��o da matriz admit�ncia de um sistema 
% el�trico de pot�ncia atrav�s de dados de entrada de tabela Excel.
% -----------------------------------------------------------------------%
% Tipos de barra:
% Tipo 0) PQ
% Tipo 1) PV
% Tipo 2) swing (V theta)
%-----------------------------------------------------------------------%

clear all;
clc;

% Constantes
DtoRad=pi/180; % Constante para transforma��o de grau para radiano

% Textos
textL={'Endere�o do arquivo das linhas:'};
textB={'Endere�o do arquivo das barras:'};
% defL={'file_line.xlsx'};
% defB={'file_bar.xlsx'};
defL={'file_line_teste_Inacio.xlsx'};
defB={'file_bar_teste_Inacio.xlsx'};
d_titleL='Arquivo das linhas';
d_titleB='Arquivo das barras';
dim=[1 50];

% Caixas de di�logo
opts.Interpreter = 'tex';
vec_line=inputdlg(textL,d_titleL,dim,defL);
vec_bar=inputdlg(textB,d_titleB,dim,defB);

% Mudan�a de cell para string
fileL=string(vec_line);
fileB=string(vec_bar);

% Cria as matrizes com os dados
TL=readtable(fileL); % Tabela das linhas
TB=readtable(fileB); % Tabela das colunas
ML=table2array(TL);  % Tabela dados de linhas de transmiss�o
MB=table2array(TB);  % Tabela de dados de barras

[szL1,szL2]=size(ML);
[szY1,szY2]=size(MB);
Y=zeros(szY1);

% Dados das linhas
BarTo=ML(:,1);              % Pega os dados de qual barra a linha est� saindo 
BarFor=ML(:,2);             % Pega os dados de qual barra est� chegando
r_serie=ML(:,3);            % R s�rie, pu
x_serie=ML(:,4);            % X s�rie, pu
Zkm=r_serie+1j*x_serie;     % Z s�rie, pu

Ykm=1./Zkm;                 % Y s�rie, pu
B_sh=ML(:,5);             % B shunt, pu
a=ML(:,6);                  % tap, pu
phi=ML(:,7)*DtoRad;         % Defasamento angular

% Substitui as rela��es de transforma��o das linhas sem transformador por 1
for i=1:length(a)
    if ~a(i)
        a(i)=1;
    end
end

% Dados das barras
Bartype=MB(:,2);                                     % Tipo da barra
NPQ=length(find(~Bartype));                          % N�mero de barrras PQ
NPV=length(find(Bartype==1));                        % N�mero de barrras PV
NVtheta=length(find(Bartype==2));                    % N�mero de barrras Vtheta
V=MB(:,3);                                           % Tens�o da barra, pu 
theta=MB(:,4)*DtoRad;                                % �ngulo
[theta1,theta2]=meshgrid(theta);                     % Cria a grade para c�lculo do �ngulo entre as barras
Pgen=MB(:,5);                                        % Pgerado, MW
Qgen=MB(:,6);                                        % Qgerado, MVAr
Pdem=MB(:,7);                                        % Pdemandado, MW
Qdem=MB(:,8);                                        % Qdemandado, MVAr
g_sh=MB(:,9);                                        % Condut�ncia paralela, pu
bj_sh=MB(:,10);                                      % Suscept�ncia paralela, pu
Sbase=sqrt(max([Pgen;Pdem])^2+max([Qgen;Qdem])^2);   % Base de pot�ncia

% % C�lculo das grandezas em pu quando n�o sao especificadas
% Pgen=MB(:,5)/Sbase;                                  % Pgerado, MW
% Qgen=MB(:,6)/Sbase;                                  % Qgerado, MVAr
% Pdem=MB(:,7)/Sbase;                                  % Pdemandado, MW
% Qdem=MB(:,8)/Sbase;                                  % Qdemandado, MVAr

% Matriz de pot�ncia
S(1,:)=(Pgen-Pdem);
S(2,:)=(Qgen-Qdem);

% Erros
eP=0.0001;
eQ=0.0001;

% Contador de itera��es
count=0;

% Vetores auxiliares
vaux=1:1:(NPQ+NPV);                    
vaux2=1:1:NPQ;
vaux2=vaux2+NPV+NPQ;

%% C�lculo da matriz admit�ncia

% Calcula os elementos que nao est�o na diagonal principal
for i=1:szL1
    k=BarTo(i);
    l=BarFor(i);
    Y(k,l)=-a(i)*exp(-1j*phi(i))*Ykm(i);
    Y(l,k)=-a(i)*exp(1j*phi(i))*Ykm(i);
end

% Acrescenta � matriz Y os elementos da diagonal principal
for j=1:szY1
    Y(j,j)=1j*bj_sh(j);
    for aux=1:szL1
        if (j==BarTo(aux))
            Y(j,j)=Y(j,j)+1j*B_sh(aux)+a(aux)^2*Ykm(aux);
        elseif (j==BarFor(aux))
            Y(j,j)=Y(j,j)+1j*B_sh(aux)+Ykm(aux);
        end
    end
end

G=real(Y); % Matriz condut�ncia
B=imag(Y); % Matriz suscept�ncia

%% Cria a matriz indicando as liga��es entre barras- Percorrendo as linhas

Mw=zeros(szY1); % Matriz omega (barras vizinhas)

for i=1:length(BarTo)
    Mw(BarTo(i),BarFor(i))=1;
    Mw(BarFor(i),BarTo(i))=1;
end

%%

x1=sort([find(~Bartype)' find(Bartype==1)']); % Organiza a parte superior do vetor de vari�veis (theta e P)
x2=sort(find(~Bartype));                      % Organiza a parte inferior do vetor de vari�veis (V e Q)

Pesp=(Pgen(x1)-Pdem(x1));                       % P especificado
Qesp=(Qgen(x2)-Qdem(x2));                       % Q especificado

% Inicializa��o das matrizes
H=zeros(NPQ+NPV);
N=zeros(NPQ+NPV,NPQ);
M=zeros(NPQ,NPQ+NPV);
L=zeros(NPQ,NPQ);
sinkl=sin(theta2-theta1);
coskl=cos(theta2-theta1);

Q2=zeros(NPQ,1);
P2=zeros(NPQ+NPV,1);

xv=[theta(x1);V(x2)];                   % x(theta,V)

%% Loop para solu��o

while 1
    count=count+1;
    
    for k=1:length(x1)
        P2(k,:)=V(x1(k))^2*G(x1(k),x1(k))+V(x1(k))*sum(Mw(x1(k),:).*V'.*(G(x1(k),:).*coskl(x1(k),:)+B(x1(k),:).*sinkl(x1(k),:)));
    end
    for k=1:length(x2)
        Q2(k,:)=-V(x2(k))^2*B(x2(k),x2(k))+V(x2(k))*sum(Mw(x2(k),:).*V'.*(G(x2(k),:).*sinkl(x2(k),:)-B(x2(k),:).*coskl(x2(k),:)));
    end
    dP=Pesp-P2;
    dQ=Qesp-Q2;

    gx=[dP;dQ];
    
    % Matriz H
    for k=1:length(x1)
        for l=1:length(x1)
            if k==l
                H(k,k)=V(x1(k))*sum(Mw(x1(k),:).*((V)'.*(-G(x1(k),:).*sinkl(x1(k),:)+B(x1(k),:).*coskl(x1(k),:))));
            elseif Mw(k,l)==1
                H(k,l)=V(x1(k))*V(x1(l))*(G(x1(k),x1(l))*sinkl(x1(k),x1(l))-B(x1(k),x1(l))*coskl(x1(k),x1(l)));
            else
                H(k,l)=0;
            end
        end
    end

    % Matriz N
    for k=1:length(x1)
        for l=1:length(x2)
            if k==l
                N(k,k)=2*V(x1(k))*G(x1(k),x1(k))+sum(Mw(x1(k),:).*((V)'.*(G(x1(k),:).*coskl(x1(k),:)+B(x1(l),:).*sinkl(x1(k),:))));
            elseif Mw(k,l)==1
                N(k,l)=V(x1(k))*(G(x1(k),x2(l))*coskl(x1(k),x2(l))+B(x1(k),x2(l))*sinkl(x1(k),x2(l)));
            else
                N(k,l)=0;
            end
        end
    end

    % Matriz M
    for k=1:length(x2)
        for l=1:length(x1)
            if k==l
                M(k,k)=V(x2(k))*sum(Mw(x2(k),:).*((V)'.*(G(x2(k),:).*coskl(x2(k),:)+B(x2(l),:).*sinkl(x2(k),:))));
            elseif Mw(k,l)==1
                M(k,l)=-V(x2(k))*V(x1(l))*(G(x2(k),x1(l))*coskl(x2(k),x1(l))+B(x2(k),x1(l))*sinkl(x2(k),x1(l)));
            else
                M(k,l)=0;
            end
        end
    end

    % Matriz L
    for k=1:length(x2)
        for l=1:length(x2)
            if k==l
                L(k,k)=-2*V(x2(k))*B(x2(k),x2(k))+sum(Mw(x2(k),:).*((V)'.*(G(x2(k),:).*sinkl(x2(k),:)-B(x2(l),:).*coskl(x2(k),:))));
            elseif Mw(k,l)==1
                L(k,l)=V(x2(k))*(G(x2(k),x2(l))*sinkl(x2(k),x2(l))-B(x2(k),x2(l))*coskl(x2(k),x2(l)));
            else
                L(k,l)=0;
            end
        end
    end

    J=-[H N; M L]; % Matriz Jacobiana

%     dP=P1-P2;
%     dQ=Q1-Q2;
    if (abs(max(dP))<eP && abs(max(dQ))<eQ)
        break;
    end
%     gx=[dP;dQ];
    dxv=-J\gx;                              % deltax(x)
    xv=xv+dxv;
    V(x2)=xv(vaux2);
    theta(x1)=xv(vaux);
    [theta1,theta2]=meshgrid(theta);
    sinkl=sin(theta2-theta1);
    coskl=cos(theta2-theta1);
    disp(count);
end

%% C�lculo das pot�ncias n�o especificadas

x3=find(Bartype==2);
% C�lculo da pot�ncia ativa das barras Vtheta
for k=1:length(x3)
    P(k)=V(x3(k))^2*G(x3(k),x3(k))+V(x3(k))*sum(Mw(x3(k),:).*((V)'.*(G(x3(k),:).*coskl(x3(k),:)+B(x3(k),:).*sinkl(x3(k),:))));
    S(1,x3(k))=P(k);
end


x3=[find(Bartype==2)' find(Bartype==1)'];
% C�lculo da pot�ncia reativa das barras Vtheta e PV
for k=1:length(x3)
    Q(k)=-V(x3(k))^2*B(x3(k),x3(k))+V(x3(k))*sum(Mw(x3(k),:).*((V)'.*(G(x3(k),:).*sinkl(x3(k),:)-B(x3(k),:).*coskl(x3(k),:))));
    S(2,x3(k))=Q(k);
end

S=S';

%% Calcula os fluxos de pot�ncia

for aux=1:length(BarTo)
     k = BarTo(aux);
     m = BarFor(aux);
     
     g = real(Ykm(aux));
     b = imag(Ykm(aux));
     
     %Pot�ncia entre as barras
     P_km(aux) = (V(k)^2)*g-V(k)*V(m)*(g*cos(theta(k) - theta(m) + phi(aux))+b*sin(theta(k) - theta(m) + phi(aux)));
     P_mk(aux) = (V(m)^2)*g-V(k)*V(m)*(g*cos(theta(k) - theta(m) + phi(aux))-b*sin(theta(k) - theta(m) + phi(aux)));
     Q_km(aux) = -(V(k)^2)*(b+B_sh(aux))+V(k)*V(m)*(b*cos(theta(k) - theta(m) + phi(aux))-g*sin(theta(k) - theta(m) + phi(aux)));
     Q_mk(aux) = -(V(m)^2)*(b+B_sh(aux))+V(k)*V(m)*(b*cos(theta(k) - theta(m) + phi(aux))+g*sin(theta(k) - theta(m) + phi(aux)));
     
end

%Fluxo de pot�ncia

fprintf('\nFluxo de Pot�ncia\n');

fprintf('\n    De   Para     Pkm      Pmk     Qkm      Qmk\n');
for aux = 1:length(BarTo)
	fprintf(' |%3d %6d %9.4f %8.4f %9.4f %8.4f |\n',BarTo(aux), BarFor(aux),P_km(aux),P_mk(aux),Q_km(aux),Q_mk(aux))
end

%% Salva os dados em um arquivo .xlsx

theta=theta/DtoRad;
T=table(V,theta,S(:,1),S(:,2));
% T.Properties.VariableNames={'V' 'theta' 'P' 'Q'};
T=table2cell(T);
folder='C:\Users\thiag\Documents\CEFET\Trabalhos\Dados_Barras';
if ~exist(folder,'dir')
    mkdir(folder);
end
filename='Saidas.xlsx';
fullFile=fullfile(folder,filename);
xlswrite(fullFile,T(:,1),'Tens�o','A1');
xlswrite(fullFile,T(:,2),'Theta','A1');
xlswrite(fullFile,T(:,3),'P','A1');
xlswrite(fullFile,T(:,4),'Q','A1');










