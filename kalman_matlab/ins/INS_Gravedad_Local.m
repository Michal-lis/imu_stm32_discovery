function gl = INS_Gravedad_local(L,h)
% Obtiene la gravedad local dependiendo de la Latitud y altura
% Fórmula sacada del IMU de Microstrain
gl = 9.780318*(1+0.0053024*sind(L)^2-0.0000058*sind(2*L)^2)-3.086e-6*h;