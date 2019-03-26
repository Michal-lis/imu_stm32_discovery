function [ qn ] = INS_Normaliza_Q(q)
% Normaliza el cuaternio
% [qn] =INS_Normaliza_Q(q)
% Input
%    q : Cuaternio
% Retorno
%    qn : Cuaternio normalizado
    Incq = 1 - (q(1)^2+q(2)^2+q(3)^2+q(4)^2);
    qn = (1-Incq)^-0.5*q;
end

