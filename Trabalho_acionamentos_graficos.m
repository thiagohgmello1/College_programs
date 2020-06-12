%% Trabalho de acionamentos industriais

% Gráfico
figure(1);
plot(altitude(:,1),altitude(:,2));
hold on;
plot(altitude(:,1),altitude(:,3));
hold on;
plot(altitude(:,1),altitude(:,4));
legend('x','y','z','Location','SouthEast');
title('Posição (referencial inercial)');
xlabel('t[s]');
ylabel('Posição[m]');

% Gráfico 3D
figure(2);
plot3(altitude(:,2),altitude(:,3),altitude(:,4));
xlabel('x[m]');
ylabel('y[m]');
zlabel('z[m]');
title('Posição(referencial inercial)');
grid();

% Esforço de controle
figure(3);
plot(Tensoes(:,1),Tensoes(:,2));
title('Esforço de controle');
xlabel('t[s]');
ylabel('V_{DC}[V]');

% Velocidade do motor
figure(4);
plot(w1(:,1),w1(:,2));
title('Velocidade angular (\omega_{i})');
xlabel('t[s]');
ylabel('\omega_{i}[rad/s]');

% Tensão de linha
figure(5);
plot(vab(:,1),vab(:,2));
title('Tensão de linha do motor');
xlabel('t[s]');
ylabel('V_{ab}');

% Conjugado de saída do motor
figure(6);
plot(Tm1(:,1),Tm1(:,2));
title('Conjugado do motor');
xlabel('t[s]');
ylabel('T_{em}[Nm]');



