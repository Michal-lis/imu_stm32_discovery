function qr = quatprod(q,p)
% Multiplicación de cuaternios 
% qr = quatprod(q,p)
% Input
%    q,p : cuaternios
% Retorno
%    qr : q*p
    qr = [q(1) -q(2) -q(3) -q(4); q(2) q(1) -q(4) q(3); q(3) q(4) q(1) -q(2); q(4) -q(3) q(2) q(1)]*p';   
end