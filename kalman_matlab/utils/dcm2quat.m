function q = dcm2quat(C)
% Convierte matriz de cosenos a quaternion 
% q = dcm2quat(C)
% Input
%    C : Matriz de cosenos
% Retorno
%    q : Vector 1x4 con el cuaternio
    a = 0.5*sqrt(1+C(1,1)+C(2,2)+C(3,3));
    b = 1/(4*a)*(C(3,2)-C(2,3));
    c = 1/(4*a)*(C(1,3)-C(3,1));
    d = 1/(4*a)*(C(2,1)-C(1,2));
    q = [a, b, c, d];
end