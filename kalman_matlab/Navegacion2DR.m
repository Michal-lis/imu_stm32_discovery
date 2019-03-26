clear;
R0 = 6378*1000; % Radio de la tierra
g = 9.81; % m/s2
TamFuente = 10;

T = 0.01; % Periodo 1s
load 'Trazas_IMU/arco2dS';
S(:,2)=-S(:,2);
S(:,4)=linspace(0,1)';

% Velocidad y posición inicial
vx(1) = 0; vz(1) = 0; Theta(1) = 0;
x(1) = 0; z(1) = 0; 

for i = 2:length(S)
    % 1) Actualizo velocidad angular e integro
    omega = S(i-1,3) - vx(i-1)/(R0+z(i-1));
    Theta(i) = Theta(i-1)+omega*T;
    
    % 2) Obtengo fuerzas especificas para ejes x,z
    fx(i) = (S(i-1,1)*cos(Theta(i-1))+S(i-1,2)*sin(Theta(i-1)))*g;
    fz(i) = (-S(i-1,1)*sin(Theta(i-1))+S(i-1,2)*cos(Theta(i-1)))*g;
    
    % 3) Calculo aceleraciones e integro 
    ax(i) = fx(i) + vx(i-1)*vz(i-1)/(R0+z(i-1));
    az(i) = fz(i) + (-g) + vx(i-1)*vx(i-1)/(R0+z(i-1));
    vx(i) = vx(i-1) + ax(i)*T;
    vz(i) = vz(i-1) + az(i)*T;
    
    % 4) Obtengo posicion integrando
    x(i) = x(i-1) + vx(i-1)*T;
    z(i) = z(i-1) + vz(i-1)*T;
    
end
    

t = S(:,4);


subplot(4,2,1);
plot(t,S(:,3));
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('rad/s');
title('Giroscopio');


subplot(4,2,3);
plot(t,Theta);
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('rad');
title('\Theta (angulo)');


subplot(4,2,2);
plot(t,S(:,1), t, S(:,2));
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('g');
legend('ax','az');
title('Lectura de acelerómetros');

subplot(4,2,4);
plot(t,fx, t, fz );
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('(m/s^2)');
legend('ax','az');
title('Aceleración resultante');


subplot(4,2,5);

plot(t,vx,t,vz);
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('m/s');
legend('x','z');
title('Velocidad vs tiempo');


subplot(4,2,6);

plot(t,x,t,z);
set(gca,'FontSize',TamFuente);
xlabel('Tiempo (s)');
ylabel('m');
legend('x','z');
title('Posición vs tiempo');



subplot(4,2,[7 8]);

plot(x, z);
set(gca,'FontSize',TamFuente);
xlabel('x (m)');
ylabel('z (m)');
title('Posición z,x');
