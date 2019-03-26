function C = euler2dcm(Psi, Theta, Phi)
% Convierte angulos euler a matrix de cosenos (direction cosine matrix) 
% C = euler2dcm(Psi, Theta, Phi)
% Input
%    Psi : rotation about z (yaw)
%    Theta : rotation about y (pitch)
%    Phi : rotation about x (roll)
% Retorno
%    C : Matriz de cosenos

    C1 = [cos(Psi) sin(Psi) 0; -sin(Psi) cos(Psi) 0; 0 0 1];
    C2 = [cos(Theta) 0 -sin(Theta); 0 1 0; sin(Theta) 0 cos(Theta)];
    C3 = [1 0 0; 0 cos(Phi) sin(Phi); 0 -sin(Phi) cos(Phi)];
    C = C1'*C2'*C3';
    
end