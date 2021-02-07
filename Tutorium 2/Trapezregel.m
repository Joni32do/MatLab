function Integralwert = Trapezregel(Funktion,x_lower,x_upper,nx)
% INTEGRALWERT = TRAPEZREGEL(FUNKTION,X_LOWER,X_UPPER,NX)
% führt eine numerische Integration einer Funktion FUNKTION
% in 1D in einem vorgegebenen Intervall [X_LOWER Y_UPPER]
% und mit einer vorgegebenen Diskretisierung nx aus.
%
% FUNKTION ist ein function handle zu einer beliebigen Funktion
% von einer Variable.

% Umsertzen der Diskretisierung
Dx         = x_upper - x_lower;  % Spanne
dx         = Dx/nx;              % Diskretisierungsweite

all_x         = x_lower : dx : x_upper;
Integralwert  = dx*...
                 (sum(Funktion(all_x(2:end)))...
                +1/2*Funktion(all_x(1))...
                +1/2*Funktion(all_x(end)));
                
