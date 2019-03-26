clear;
R0 = 6378*1000; % Radio de la tierra
g = 9.81; % m/s2

% Las trayectorias se definen como fx,fz,wy,t
%  fx,fz fuerzas especificas sobre el cuerpo (g)
%  wy velocidad angular (rad/s)
%  t tiempo durante el que se mantiene estos valores.

T = 1; % <<---- PERIODO

% Trayectoria a=1g arriba 100s -> z = 1/2*9.81*100^2=49.050m
Tr1 = [1,1,0,100];%por que cambia la altura

% Trayectoria a=1g horizontal 100s -> z = 1/2*9.81*100^2=49.050m
Tr2 = [1,1,0,10];

% Trayectoria0: fx,fz,wy,t
Tr3 = [0,2,0,100;     % Aceleración 2g para vencer fuerza gravedad (100s)
     0,2,pi/20,10;  % giro 90º en 10s
     0,2,0,10;       % Seguimos acelerando 10s
     0,0,0,229];      % Fin de aceleración. Caída libre 200s

 % Trayectoria Alan Eustace
Tr4 = [0,20,0,100;
    0,0,0,500];
 
% Genera la información de los sensores
S=trayectoria2D(Tr1,T);  % <<----- TRAYECTORIA

% Velocidad y posición inicial
vx(1) = 0; vz(1) = 0; Theta(1) = 0;
x(1) = 0 ; z(1) = 0 ; 

for i = 2:length(S)
    % 1) Actualizo velocidad angular e integro
    omega = S(i-1,3) - vx(i-1)/(R0+z(i-1));
    Theta(i) = Theta(i-1)+omega*T;
    
    % 2) Obtengo fuerzas especificas para ejes x,z
    fx(i) = (S(i-1,1)*cos(Theta(i-1))+S(i-1,2)*sin(Theta(i-1)))*g;
    fz(i) = (-S(i-1,1)*sin(Theta(i-1))+S(i-1,2)*cos(Theta(i-1)))*g;
    
    % 3) Calculo aceleraciones e integro 
    ax = fx(i) + vx(i-1)*vz(i-1)/(R0+z(i-1));
    az = fz(i) + (-g) + vx(i-1)*vx(i-1)/(R0+z(i-1));
    vx(i) = vx(i-1) + ax*T;
    vz(i) = vz(i-1) + az*T;
    
    % 4) Obtengo posicion integrando
    x(i) = x(i-1) + vx(i-1)*T;
    z(i) = z(i-1) + vz(i-1)*T;
    
end
    

fprintf('T=%g  X=%g z=%g Theta(max-ABS)=%g\n', T, max(x), max(z), max(abs(Theta)));

%plot(T, F(:,1));
subplot(2,1,1);
t = S(:,4);
plot(t,z);
set(gca,'FontSize',18);
xlabel('Tiempo (s)');
ylabel('Altura (m)');
title('Altura vs tiempo');

subplot(2,1,2);
plot(x, z);
set(gca,'FontSize',18);
xlabel('x (m)');
ylabel('z (m)');
title('Posición z,x');