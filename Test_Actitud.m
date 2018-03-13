clear all;


Orden = 1;
Algoritmo = 2;
; % 1 = DCM / 2 = cuaternios

load 'Trazas_IMU/Paseo1';
%load 'Trazas_IMU/giros';
%load 'Trazas_IMU/giros_fuertes';


Periodo = D(2).T-D(1).T;
tam = length(D);
Tinicio = D(1).T;
Tfin = D(tam).T;



E = zeros(tam,3);


if Algoritmo == 1
    % Se trabaja con matriz de cosenos
    % Actitud inicial
    C = D(1).C';
    [Psi, Theta, Phi] = dcm2euler(C);
    E(1,:) = [Psi, Theta, Phi];
    for i = 1:tam-1
        Periodo = D(i+1).T - D(i).T; % Por si acaso el periodo entre muestras varia
        C = INS_Actitud_DCM_1(D(i).W, C, Periodo, Orden); %%%% CALCULAR LA ACTITUD USANDO DCM 
        [Psi, Theta, Phi] = dcm2euler(C); %%% CALCULAR ANGULO
        E(i+1,:) = [Psi, Theta, Phi];
    end
else
    % Se trabaja con cuaternios
    % Actitud inicial
    q = dcm2quat(D(1).C');
    [Psi, Theta, Phi] = dcm2euler(quat2dcm(q));
    E(1,:) = [Psi, Theta, Phi];
    for i = 1:tam-1 
        Periodo = D(i+1).T - D(i).T; % Por si acaso el periodo entre muestras varia
        q = INS_Actitud_Q_1(D(i).W, q, Periodo, Orden);
        C = quat2dcm(q);%%%% CALCULAR LA ACTITUD USANDO Q 
        [Psi, Theta, Phi] = dcm2euler(C) %%% CALCULAR ANGULO
        E(i+1,:) = [Psi, Theta, Phi];
    end
end

%% Se calculan los angulos de la traza del IMU
E2 = zeros(tam,3);
T  = zeros(tam,1);
W  = zeros(tam,3);
for i = 1:tam
    [Psi, Theta, Phi] = dcm2euler(D(i).C');
    E2(i,:) = [Psi, Theta, Phi];
    T(i) = D(i).T;
    W(i,:) = D(i).W;
end

fprintf('Error = %g %g %g\n', E(tam,1)-E2(tam,1), E(tam,2)-E2(tam,2), E(tam,3)-E2(tam,3));



subplot(4,1,1);



plot(T, W(:,1), T, W(:,2), T, W(:,3));
xlabel('T(s)');
ylabel('rad/s');
legend('w_x','w_y','w_z');
title('Velocidad angular giroscopios');

subplot(4,1,2)

plot(T, E(:,1), T, E2(:,1));
xlabel('T(s)');
ylabel('rad');
legend('Test','IMU');
title('\Psi (rad alrededor z)');


subplot(4,1,3)

plot(T, E(:,2), T, E2(:,2));
xlabel('T(s)');
ylabel('rad');
legend('Test','IMU');
title('\Theta (rad alrededor y)');

subplot(4,1,4)

plot(T, E(:,3), T, E2(:,3));
xlabel('T(s)');
ylabel('rad');
legend('Test','IMU');
title('\Phi (rad alrededor x)');

