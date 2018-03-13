clear all;

Periodo = 0.1;

% Defino la trayectoria:

% Despegamos
Tr1(1).F = [1,0,-0.5];
Tr1(1).W = [0,0,0];
Tr1(1).T = 30;

% Disminuyo aceleración horizontal
Tr1(2).F = [0.5,0,-1.5];
Tr1(2).W = [0,0,0];
Tr1(2).T = 30;

% Me mantengo
Tr1(3).F = [0,0,-1];
Tr1(3).W = [0,0,0];
Tr1(3).T = 30;


D = INS_SimulaIMU(Tr1, Periodo);

tam = length(D);

for i = 1:tam
    F(i,:) = D(i).F;
    W(i,:) = D(i).W;
    T(i,:) = D(i).T;
end



tam = length(D);
%tam = 3000; %%%%%%%
Tinicio = D(1).T;
Tfin = D(tam).T;

T  = zeros(tam,1);
W  = zeros(tam,3);
tant = D(1).T;
for i = 1:tam
    T(i) = D(i).T;
    W(i,:) = D(i).W;
    F(i,:) = D(i).F;
end



E = zeros(tam,3);
X = zeros(tam,3);
V = zeros(tam,3);
P = zeros(tam,3);

X(1,:) = [ 0, 0, 0];
V(1,:) = [ 0, 0, 0];
P(1,:) = [ 39.483, 0.347, 12]; % Posición de mi despacho


% Se trabaja con matriz de cosenos
% Actitud inicial a ceros
C = euler2dcm(0,0,0);
[Phi, Theta, Psi] = dcm2euler(C);
E(1,:) = [Phi, Theta, Psi];
for i = 1:tam-1
    dt = D(i+1).T - D(i).T; % Por si acaso el periodo entre muestras varia
    [X(i+1,:), P(i+1,:), V(i+1,:), C] = INS_Posicion_2(W(i,:), F(i,:), C, X(i,:), P(i,:), V, dt, i);
    [Phi, Theta, Psi] = dcm2euler(C);
    E(i+1,:) = [Phi, Theta, Psi];
end


subplot(4,2,1);

plot(T, W(:,1), T, W(:,2), T, W(:,3));
xlabel('T(s)');
ylabel('rad/s');
legend('w_x','w_y','w_z');
title('Velocidad angular giroscopios');

subplot(4,2,3)

plot(T, E(:,1), T, E(:,2), T, E(:,3));
xlabel('T(s)');
ylabel('rad');
legend('\Phi (x)','\Theta (y)','\Psi (z)');
title('Actitud');

subplot(4,2,5)

plot(T, F(:,1), T, F(:,2), T, F(:,3));
xlabel('T(s)');
ylabel('g');
legend('a_x','a_y','a_z');
title('Medida acelerometros (g)');


subplot(4,2,7)

plot(T, V(:,1), T, V(:,2), T, V(:,3));
xlabel('T(s)');
ylabel('m/s');
legend('V_x','V_y','V_z');
title('Velocidad marco navegación');

subplot(4,2,2)

plot(T, X(:,1), T, X(:,2), T, X(:,3));
xlabel('T(s)');
ylabel('m');
legend('X_x','X_y','X_z');
title('Posición marco navegación');

subplot(4,2,[4 8])

plot3(P(:,1), P(:,2), -P(:,3));
xlabel('longitud (º)');
ylabel('latitud (º)');
zlabel('altura');
grid on;
title('Posición marco navegación');

