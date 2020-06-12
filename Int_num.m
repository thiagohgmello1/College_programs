function [gx,gy,gz] = Int_num(x,y,z,Xv)
%G calcula a integral numérica da funcao f(x) utilizando o método dos
%trapézios
dx=1/(length(Xv)-1);
Ix=length(Xv);
Ex=((x+1)/(2*((x+1)^2+y^2+z^2)^(3/2))+(x-1)/(2*((x-1)^2+y^2+z^2)^(3/2)))*dx;
Ey=(y/(2*((x+1)^2+y^2+z^2)^(3/2))+y/(2*((x-1)^2+y^2+z^2)^(3/2)))*dx;
Ez=(z/(2*((x+1)^2+y^2+z^2)^(3/2))+z/(2*((x-1)^2+y^2+z^2)^(3/2)))*dx;
for i=1:Ix-1
    Ex=Ex+(x-Xv(i))*dx/(((x-Xv(i))^2+y^2+z^2)^(3/2));
    Ey=Ey+y*dx/(((x-Xv(i))^2+y^2+z^2)^(3/2));
    Ez=Ez+z*dx/(((x-Xv(i))^2+y^2+z^2)^(3/2));
end
gx=Ex;
gy=Ey;
gz=Ez;
end

