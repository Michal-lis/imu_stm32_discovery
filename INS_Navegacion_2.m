function [vk1, xk1, pk1] = INS_Navegacion_2(unk, V, xk, pk, dt, i, metodo, g)
% Obtiene la posición y velocidad usando las ecuaciones de navegación
% Versión 2: Con corrección de coriolis y posición geográfica
%[vk1, xk1, pk1] = INS_Navegacion(unk, V, xk, T, i, metodo)
% Input
%    unk : Cambio de velocidad entre periodo k y k+1 (integral de fn)
%    V  : matriz con los vectores de velocidad anterior
%    xk : vector posición anterior
%    pk : vector posición geografica anterior
%    dt : Periodo
%    i  : indice
%    metodo : metodo integración espacio (1:rectangular, 2:trapezoidal; 3:simpsons)
%    g : aceleración gravitacional (g)
% Retorno
%    vk1 : vector velocidad 
%    xk1 : vector posición (metros)
%    pk1 : vector posición geográfico (Longitud (grados), latitud (grados), altura)

OMEGA = 7.292115e-5; % Rotación de la tierra en rad/s
Re = 6378137; % Radio de la tierra en metros

G = [0, 0, g];

% Cálculo de la Corrección de Coriolis 
vN = V(i,1); vE = V(i,2);  
L  = pk(1); h  = pk(3);
omega_ie = [OMEGA*cosd(L), 0, -OMEGA*sind(L)]';
Omega_ie = skewmatrix(omega_ie);
omega_en = [vE/(Re+h), -vN/(Re+h), -vE*tand(L)/(Re+h)]';
Omega_en = skewmatrix(omega_en);
    
I = eye(3);
CC = (I-2*Omega_ie*dt-Omega_en*dt);
    
% Primero se obtiene la velocidad
% vk1 = V(i,:) + unk + V(i,:)*CC +  G*dt;
vk1 = V(i,:)*CC + unk + G*dt;
V(i+1,:) = vk1;

% Integramos para obtener posición
xk1 = INS_IntegraPosicion(metodo, xk, V, i, dt);

% Calculamos posición geográfica
C = [1/(Re+h), 1/((Re+h)*cos(L)), -1];
pk1 = INS_IntegraPosicion(metodo, pk, V, i, dt, C);



end

