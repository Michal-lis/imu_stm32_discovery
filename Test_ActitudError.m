clear;
Periodo = 0.01;
Orden = 3;
Ttotal = 60;
giro = 2*pi; % Una vuelta por segundo
Algoritmo = 1; % matriz de cosenos


% Defino la trayectoria:
% dar vueltas en el eje x
Tr1(1).F = [1,0,-1];
Tr1(1).W = [giro,0,0];  % rad/s
Tr1(1).T = Ttotal;   

D = INS_SimulaIMU(Tr1, Periodo);

tam = length(D);

%tam = 100; %%%%%%%%

E = zeros(tam+1,3);


if Algoritmo == 1
    % Se trabaja con matriz de cosenos
    % Actitud inicial
    C = euler2dcm(0,0,0);
    for i = 1:tam 
        C= INS_Actitud_DCM_1(D(i).W, C, Periodo ,Orden);   
        [Psi, Theta, Phi] = dcm2euler(C);
        E(i+1,:) = [Psi, Theta, Phi];
    end
    De = INS_ErrorActitud_DCM(giro*Periodo, Periodo, Orden);
else
    % Se trabaja con cuaternios
    % Actitud inicial
    q = dcm2quat(euler2dcm(0,0,0));
    for i = 1:tam 
        q= INS_Actitud_Q_1(D(i).W, q, Periodo, Orden);
        [Psi, Theta, Phi] = dcm2euler(quat2dcm(q));
        E(i+1,:) = [Psi, Theta, Phi];
    end
    De = INS_ErrorActitud_Q(giro*Periodo, Periodo, Orden);
end
    
    
% Estima errores

DeS = 3600/Ttotal*abs(E(tam+1,1))*(180/pi);


fprintf('Error posicion %g  Orden = %g De=%4.4gº/h DeS=%4.4gº/h\n', E(tam+1,1), Orden, De, DeS);

for i = 1:tam
    T(i) = D(i).T;
end
T(tam+1) = T(tam)+Periodo;


plot(T, E(:,1));


