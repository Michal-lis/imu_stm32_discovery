function [Ck1] =INS_Actitud_DCM_1(W, Ck, T, orden)
% Calcula la actitud C(k+1) a partir de la C(k)
% Versión 1. 
% [Ck1] =INS_Actitud_DCM(W, Ck, T, orden)
% Input
%    W : Vector con la velocidad angular
%    Ck : actitud anterior (matriz de cosenos)
%    T : Periodo
%    orden : orden del algoritmo (por defecto 3)
% Retorno
%    Ck1 : Actitud actualizada (matriz de cosenos)

if nargin < 4
    orden = 3;
end

% Integramos W para obtener sigma
sigma = W*T;

% Se calcula Ak
Ak = INS_Calcula_Ak(sigma,orden);

% Se actualiza la matriz de cosenos
Ck1 = Ck*Ak;


end