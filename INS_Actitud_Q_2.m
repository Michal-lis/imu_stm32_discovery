function [qk1] =INS_Actitud_Q_2(W, qk, T, orden)
% Calcula la actitud q(k+1) a partir de la q(k) usando cuaternios
% Versión 2. Normaliza el cuaternio
% [Ck1] =INS_Actitud_Q(W, Ck, T, orden)
% Input
%    W : Vector con la velocidad angular
%    qk : actitud anterior 
%    T : Periodo
%    orden : orden del algoritmo
% Retorno
%    qk1 : Actitud actualizada (quaternion)

if nargin < 4
    orden = 3;
end
    

% Integramos W para obtener sigma
sigma = W*T;
    
% Calculamos ac y as en función de 0.5sigma^2 y del orden
msigma2 = 0.25*(sigma(1)^2+sigma(2)^2+sigma(3)^2); % (0.5*sigma)^2
[ac,as] = INS_Terminos_Q(msigma2,orden);
    
% Se calcula rk
rk = [ ac, as*sigma(1), as*sigma(2), as*sigma(3)];    
    
% Se actualiza el cuaternio
qk1 = quatprod(qk,rk);

% Normaliza 
qk1 = INS_Normaliza_Q(qk1);
 

end