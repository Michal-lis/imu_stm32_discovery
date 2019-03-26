function [Ck1] =INS_Actitud_DCM_3(W, Ck, pk, vk, dt, orden)
% Calcula la actitud C(k+1) a partir de la C(k)
% Versión 3. Normaliza y corrección por rotación
% [Ck1] =INS_Actitud_DCM(W, Ck, T, orden)
% Input
%    W : Vector con la velocidad angular
%    Ck : actitud anterior (matriz de cosenos)
%    pk : vector con la posición geográfica  (Longitud (grados), latitud
%           (grados), altura)
%    vk : vector con la velocidad anterior
%    dt : Periodo
%    orden : orden del algoritmo (por defecto 3)
% Retorno
%    Ck1 : Actitud actualizada (matriz de cosenos)

OMEGA = 7.292115e-5; % Rotación de la tierra en rad/s
Re = 6378137; % Radio de la tierra en metros

if nargin < 6
    orden = 3;
end

% Integramos W para obtener sigma
sigma = W*dt;

% Se calcula Ak
Ak = INS_Calcula_Ak(sigma,orden);

% Cálculo de la corrección por rotación
vN = vk(1); vE = vk(2);  
L  = pk(1); h  = pk(3);
omega_ie = [OMEGA*cosd(L), 0, -OMEGA*sind(L)]';
omega_en = [vE/(Re+h), -vN/(Re+h), -vE*tand(L)/(Re+h)]';
omega_in = omega_ie + omega_en;
rho = omega_in*dt;
Bk = INS_Calcula_Ak(rho,orden);

% Se actualiza la matriz de cosenos
%Ck1 = Ck*Ak - Ck*Bk;
Ck1 = Ck*Ak*Bk;

% Normaliza
Ck1 = INS_Normaliza_DCM(Ck1);


    
end