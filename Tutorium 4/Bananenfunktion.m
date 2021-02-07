function [x,y,c] = Bananenfunktion(x_bounds, y_bounds, nx, ny)
% [X,Y,C]=BANANENFUNKTION(X_BOUNDS, Y_BOUNDS,NX,NY)
% wertet Rosenbrocks Bananenfunktion auf einem
% regelmäßigen Gitter in einem vorgegebenen Intervallen aus
%
% Eingangsparameter:
% X_BOUNDS und Y_BOUNDS: Intervalle in X und Y für die Auswertung
%                        (jeweils Pber- und Untergrenze)
% NX und NY            : Anzahl Gitterpunkte pro Richtung
%
% Ausgabeargumente:
% X, Y                 : Koordinaten des regelmäßigen Gitters
% C                    : Werte der Bananenfunktion an den Stellen
%                        in X und Y.

% Liste der Gitterkoordinaten in x und y erzeugen
x_Vektor = linspace(x_bounds(1),x_bounds(2),nx);
y_Vektor = linspace(y_bounds(1),y_bounds(2),ny);

% Gitter erzeugen
[x,y]    = meshgrid(x_Vektor,y_Vektor);

% Rosenbrocks Bananenfunktion auswerten
c        = 100*(y-x.^2).^2+(1-x).^2;

