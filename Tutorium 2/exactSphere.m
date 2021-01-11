%Funktion die einen den exakten Wert eine Hyper-Kugel in
%n Dimensionen gibt
function vol = exactSphere(r,n)
vol = pi.^(n/2)./gamma(n/2 + 1).*r.^n;
end