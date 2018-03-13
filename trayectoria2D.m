function S =trayectoria2D(Tr, T)
% Simula la generación de datos del IMU a partir de una trayectorio dada.
% D =trayectoria2D(D, U, i)
% Input
%    Tr : Trayectoria (fx,fz,wy,t)
%          Tr(i).F : Vector con la fuerza especifica (aceleración)
%          Tr(i).W : Vector con la vector angular
%          Tr(i).T : Tiempo en el que empiezan estos datos.
%    T : Periodo
%    Dur : Duración, en segundo de la simulación.
% Retorno
%    S : Valor de los sensores.
Ttotal = 0;
TamTr = size(Tr);
for i = 1:TamTr
    Ttotal = Ttotal + Tr(i,4);
end
Elementos = Ttotal/T;

j = 1;
tAnt = 0;
for i = 1:Elementos
    t = i*T;
    if j+1 <= TamTr & Tr(j,4) < t - tAnt
        j = j + 1;  % Se cambia de elemento j.
        tAnt = t;
    end
    S(i,:) = Tr(j,:);
    S(i,4) = t;   
end


end


