%Integriert eine n-Dimensionale Kugeln mit ca. m Punkten
% auf dem Intervall [0,r]^n
function vol = NumIntRechteckKugel(r,n,m)
p = round(m.^(1/n));
if p < 5
    warning('Few Points for this Dimension')
end

grid = linspace(0,r,p);

Ndarrays = cell(1, n);
[Ndarrays{:}] = ndgrid(grid);  

%Über alle Dimensionen quadrieren
volInt = Ndarrays{1}.^2;
for i = 2:n
    volInt = volInt + Ndarrays{i}.^2;
end

volInt = volInt < 1;
%alle 1en zählen und damit Dimensionen "kollabieren" lassen
for i = 1:n
    volInt = sum(volInt);
end

%Nun noch die Normierung
unitDimCube = (r/(p-1)).^n;
vol = unitDimCube .* volInt;
end