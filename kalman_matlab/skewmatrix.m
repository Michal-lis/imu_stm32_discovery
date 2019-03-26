function SM = skewmatrix(a)
% skewmatrix - returns skew matrix for 3D vector
if ~isnumeric(a) && numel(a) ~= 3 % ...etc
  error('3-element numeric vector expected')
end
SM = [0 -a(3) a(2) ; a(3) 0 -a(1); -a(2) a(1) 0] ;
% END OF FUNCTION