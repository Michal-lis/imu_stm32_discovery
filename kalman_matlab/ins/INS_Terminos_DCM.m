function [a1,a2] = INS_Terminos_DCM(sigma2, orden)
    % Calcula los terminos a1 y a2 en funcion del orden y sigma al cuadrado.
    a1 = 1;
    a2 = 0;
    signo_a1=-1;
    signo_a2=+1;
    for i = 2:orden
        if mod(i,2) == 1
            % Se actualiza a1
            a1 = a1 + signo_a1*sigma2^((i-1)/2)/factorial(i);
            signo_a1=signo_a1*-1;
        else
            % Se actualiza a2
            a2 = a2 + signo_a2*sigma2^((i-2)/2)/factorial(i);
            signo_a2=signo_a2*-1;
        end
    end
    
end