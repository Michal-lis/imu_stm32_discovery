function De =INS_ErrorActitud_DCM(sigma, T, orden)
% Calcula el error de actitud para matriz de cosenos (en un solo eje)
% De =INS_ErrorActitud_DCM(sigma, T, orden)
% Input
%    sigma : Vector con la velocidad angular
%    T : Periodo
%    orden : orden del algoritmo
% Retorno
%    De : Deriva en grados/hora

[a1,a2]=INS_Terminos_DCM(sigma^2,orden);
Ddc=1/T*(sigma*a1*cos(sigma)-sin(sigma)+sigma^2*a2*sin(sigma));
De=abs(Ddc)*3600*(180/pi);

end

