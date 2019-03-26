function De =INS_ErrorActitud_Q(sigma, T, orden)
% Calcula el error de actitud para cuaternios (en un solo eje)
% De =INS_ErrorActitud_Q(sigma, T, orden)
% Input
%    sigma : Vector con la velocidad angular
%    T : Periodo
%    orden : orden del algoritmo
% Retorno
%    De : Deriva en grados/hora
[ac,as]=INS_Terminos_Q(0.25*sigma^2,orden);
Dq=1/T*(2*sigma*ac*as*cos(sigma)-ac^2*sin(sigma)+sigma^2*as^2*sin(sigma));
De=abs(Dq)*3600*(180/pi);    

end

