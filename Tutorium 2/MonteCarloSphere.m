%Berechnet das Volumen per Monte Carlo Integrationsmethode
function vol = MonteCarloSphere(r,n,m)
maschinengewehrkugel = 0;
getroffen = 0;
for i = 1:m
    for j = 1:n
       maschinengewehrkugel = maschinengewehrkugel + rand(r).^2;
    end
    if maschinengewehrkugel <= 1
        getroffen = getroffen + 1;
    end
    maschinengewehrkugel = 0;
end
ergebnis = getroffen./m;
vol = ergebnis.*(r^n);
end