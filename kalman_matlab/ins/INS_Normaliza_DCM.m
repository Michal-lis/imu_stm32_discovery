function [ Cn ] = INS_Normaliza_DCM( C)
% Normaliza la matriz de cosenos
% [Cn] =INS_Normaliza_DCM(C)
% Input
%    C : Matriz de cosenos
% Retorno
%    Cn : Matriz de cosenos
    for i = 1:3
        Incii = 1- (C(i,1)^2+C(i,2)^2+C(i,3)^2);
        Cn(i,:) = (1 + 0.5*Incii)*C(i,:);
    end
end