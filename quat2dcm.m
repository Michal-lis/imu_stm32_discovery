function C = quat2dcm(q)
% Convierte de cuaternio a matrix de cosenos (direction cosine matrix) 
% C = quat2dcm(q)
% Input
%    q : vector de 4 elementos con el cuaternio
% Retorno
%    C : Matriz de cosenos
    a= q(1); b=q(2); c=q(3); d=q(4);
    C(1,1) = a^2 + b^2 - c^2 - d^2;
    C(1,2) = 2*(b*c - a*d);
    C(1,3) = 2*(b*d + a*c);
    C(2,1) = 2*(b*c + a*d);
    C(2,2) = a^2 - b^2 + c^2 - d^2;
    C(2,3) = 2*(c*d - a*b);
    C(3,1) = 2*(b*d - a*c);
    C(3,2) = 2*(c*d + a*b);
    C(3,3) = a^2 - b^2 - c^2 + d^2;
end