clear all;


%load 'Trazas_IMU/Paseo1';
%load 'Trazas_IMU/giros';
load 'Trazas_IMU/giros_fuertes';

tam = length(D);

for i = 1:tam
    W(i,:) =D(i).W; % COMPLETAR
    F(i,:) =D(i).F; % CONPLETAR
    C =D(i).C;
    T(i) = D(i).T;
    [Psi, Theta, Phi] = dcm2euler(D(i).C); % REALIZAR CONVERSIÓN
    E(i,:) = [Psi, Theta, Phi];
end



subplot(5,1,1);

plot(T, W(:,1), T, W(:,2), T, W(:,3));
xlabel('T(s)');
ylabel('rad/s');
legend('w_x','w_y','w_z');
title('Velocidad angular giroscopios');

subplot(5,1,2)

plot(T, F(:,1), T, F(:,2), T, F(:,3));
xlabel('T(s)');
ylabel('g');
legend('F_x','F_y','F_z');
title('Fuerza específica');

subplot(5,1,3)

plot(T, E(:,1));
xlabel('T(s)');
ylabel('rad');
title('\Psi (rad alrededor z)');


subplot(5,1,4)

plot(T, E(:,2));
xlabel('T(s)');
ylabel('rad');
title('\Theta (rad alrededor y)');

subplot(5,1,5)

plot(T, E(:,3));
xlabel('T(s)');
ylabel('rad');
title('\Phi (rad alrededor x)');
