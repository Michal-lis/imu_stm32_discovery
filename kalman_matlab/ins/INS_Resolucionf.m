function [un] = INS_Resolucionf(C, fb, W, T, g)
% Resolución e integración de las fuerzas especifica en el marco de navegación
% [un] = INS_Resolucionf(C, fb, W, T, g)
% Input
%    C : actitud 
%    fb : Vector con la fuerza especifica
%    W : Vector con la velocidad angular
%    T : Periodo
%    g : fuerza gravitacional (g)
% Retorno
%    un : Cambio de velocidad entre periodo k y k+1 (integral de fn)

% Integramos W para obtener sigma
sigma = W*T;
% Integramos fb para obtener velocidad 
v = fb*T*g;

un = C*(v+0.5*cross(sigma,v))';

end

