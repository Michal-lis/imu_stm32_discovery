function [Psi, Theta, Phi] = dcm2euler(C)
% Convierte matriz de cosenos a angulos euler 
% [Psi, Theta, Phi] = dcm2euler(C)
% Input
%    C : Matriz de cosenos
% Retorno
%    Psi : rotation about z (yaw)
%    Theta : rotation about y (pitch)
%    Phi : rotation about x (roll)
    Phi = atan2(C(3,2),C(3,3));
    Theta = asin(-C(3,1));
    Psi = atan2(C(2,1),C(1,1));
    
end