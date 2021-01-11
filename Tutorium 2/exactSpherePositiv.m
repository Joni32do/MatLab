%Funktion die einen den exakten Wert eine Hyper-Kugel in
%n Dimensionen auf dem Hauptquadranten gibt
function vol = exactSpherePositiv(r,n)
vol = exactSphere(r,n)./(2.^n);
end