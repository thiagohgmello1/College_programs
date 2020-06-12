%clear all;
ER=4.3;
E0=1e-9/(36*pi);
AA=152.5e-3;
BB=200e-3;
D=1.53e-3;
N=64;
NT=2*N;
M=sqrt(N);
DX=AA/M;
DY=BB/M;
DL=DX;
K=0;
for K1=1:2
    for K2=1:M
        for K3=1:M
            K=K+1;
            X(K)=DX*(K2-0.5);
            Y(K)=DY*(K3-0.5);
        end
    end
end
for K1=1:N
    Z(K1)=0;
    Z(K1+N)=D;
end
for I=1:NT
    for J=1:NT
        if (I==J)
            A(I,J)=DL*0.8814/(pi*E0*ER);
        else
            R=sqrt((X(I)-X(J))^2+(Y(I)-Y(J))^2+(Z(I)-Z(J))^2);
            r(I,J)=R;
            A(I,J)=DL^2/(4*pi*E0*R*ER);
        end
    end
end
for K=1:N
    B(K)=1;
    B(K+N)=-1;
end
RHO=B/A;
SUM=0;
for I=1:N
    SUM=SUM+RHO(I);
end
Q=SUM*(DL^2);
VO=2;
C=abs(Q)/VO;