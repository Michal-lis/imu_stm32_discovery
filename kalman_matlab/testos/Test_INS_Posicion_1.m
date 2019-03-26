clear all;



%load 'Trazas_IMU/Paseo1';
load 'Trazas_IMU/arco2';
%load 'Trazas_IMU/Reposo';
%load 'Trazas_IMU/giros';



Periodo = D(2).T-D(1).T;
tam = length(D);
%tam = 3000; %%%%%%%
Tinicio = D(1).T;
Tfin = D(tam).T;

E2 = zeros(tam,3);
T  = zeros(tam,1);
W  = zeros(tam,3);
tant = D(1).T;
for i = 1:tam
    [Psi, Theta, Phi] = dcm2euler(D(i).C');
    T(i) = D(i).T;
    W(i,:) = D(i).W;
    F(i,:) = D(i).F;
end



E = zeros(tam,3);
X = zeros(tam,3);
V = zeros(tam,3);

X(1,:) = [ 0, 0, 0];
V(1,:) = [ 0, 0, 0];


% Se trabaja con matriz de cosenos
% Actitud inicial a ceros
C = euler2dcm(0,0,0);
[Psi, Theta, Phi] = dcm2euler(C);
E(1,:) = [Psi, Theta, Phi];
for i = 1:tam-1
    dt = D(i+1).T - D(i).T; % Por si acaso el periodo entre muestras varia
    [X(i+1,:), V(i+1,:), C] = INS_Posicion_1(W(i,:), F(i,:), C, X(i,:), V(i,:), dt);
    [Psi, Theta, Phi] = dcm2euler(C);
    E(i+1,:) = [Psi, Theta, Phi];
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
legend('\Psi (z)','\Theta (y)','\Phi (x)');
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

Xmax = max(max(X));
Xmin = min(min(X));
plot3(X(:,1), X(:,2), X(:,3));
xlim([Xmin, Xmax]); 
ylim([Xmin, Xmax]); 
zlim([Xmin, Xmax]); 
xlabel('x(m)');
ylabel('y(m)');
zlabel('z(m)');
grid on;
title('Posición marco navegación');

