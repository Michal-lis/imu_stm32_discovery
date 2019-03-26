function qc = quatconj(q)
% Obtiene el conjugado del cuaternio , esto es q* 
% qc = quatconj(q)
% Input
%    q : cuaternio
% Retorno
%    qc : conjugado
    qc = [q(1) -q(2) -q(3) -q(4)];  
end