function Ak =INS_Calcula_Ak(sigma, orden)
% Calcula la matriz Ak que relación la matriz de cosenos entre
% dos periodos
% Ak =INS_Calcula_Ak(sigma, orden)
% Input
%    sigma : Vector sigma
%    orden : orden del algoritmo (por defecto 3)
% Retorno
%    Ak : Matriz Ak

% Calculamos matriz antisimetrica
SigmaA = skewmatrix(sigma);

% Calculamos a1 y a2 en función del orden del algoritmo
sigma2 = sigma(1)^2+sigma(2)^2+sigma(3)^2; % (sigma^2)
[a1,a2] = INS_Terminos_DCM(sigma2, orden);

% Se calcula Ak
I = eye(3,3);
Ak = I+a1*SigmaA+a2*SigmaA^2;

end