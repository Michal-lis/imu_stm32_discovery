function [xk1, vk1, Ck1] =INS_Posicion_1Q(W, fb, Ck, xk, vk, dt)
% Calcula la posición a partir de los datos del IMU utilizando
% matriz de cosenos.
% Versión 1: Usando las funciones:
%  Cuaternios, orden 4, Normalizado, e integración trapezoidal
%  [xk1, vk1, Ck1] =INS_Posicion_1(W, fb, Ck, xk, vk, dt)
% Input
%    W : Vector con la velocidad angular
%    fb : Vector con la fuerza especifica
%    Ck : actitud anterior (matriz de cosenos). Despues se convierte a q
%    xk : vector con la posición anterior
%    vk : vector con la velocidad anterior
%    dt : Periodo
% Retorno
%    xk1 : Vector Posición X,Y,Z (en metros) relativa a la posición inicial
%    vk1 : Vector velocidad
%    Ck1 : Matriz de cosenos actualizada
g = 9.80665;

qk = dcm2quat(Ck);
%% Completar
Ck1 = quat2dcm(qk1);

%% Completar
end