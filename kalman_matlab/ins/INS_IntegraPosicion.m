function xk1 = INS_IntegraPosicion(metodo, xk, V, i, dt, C)
% Integra posicion  
% xk1 = INS_IntegraPosicion(metodo, xk, V, i, T, C)
% Input
%    metodo : metodo integracion (1:rectangular, 2:trapezoidal; 3:simpsons)
%    xk : vector con la posición anterior
%    V : array de vectores con la velocidades (desde i+1 a 1)
%    i : indice actual
%    dt : Intervalo
%    C : Corrección -> sirve para integrar en longitud y latitudes.
% Retorno
%    xk1 : Vector Posición integrado
if nargin < 6
        C = [1 1 1];
end
switch metodo 
    case 1
        % Integramos (rectangular)
        xk1 = xk + V(i,:).*C*dt;
    case 2
        % Integramos (trapezoidal)
        xk1 = xk + (V(i,:)+V(i+1,:))/2.*C*dt;
    case 3
        % Integramos (Simpson's)
        if (i > 2)
            xk1 = xk + (V(i-1,:)+V(i,:)+V(i+1,:))/3.*C*dt;
        else
            xk1 = xk + (V(i,:)+V(i+1,:))/2.*C*dt;
        end
end        
end