%Numerik Blatt 8
%Hab aufgegeben alles im Kopf zu probieren, das erzeugt nur sehr viele
%Fehler und Frustration
Q1 = 1/6 * [-3 3 -3 -3; 3 5 1 1; -3 1 5 -1; -3 1 -1 5]
Q2 = [1 0 0 0; 0 -2/3 2/3 -1/3; 0 2/3 11/15 2/15; 0 -1/3 2/15 14/15]
Q3 = [1 0 0 0; 0 1 0 0; 0 0 -3/5 4/5; 0 0 4/5 3/5]
A = [3 6 19; -3 2 1; 3 -2 17; 3 6 1]

Q = Q1*Q2*Q3
R = Q3*Q2*Q1*A
x = [34;2;16;16]
y = Q'*x
x = [1; 2; 1]

Q*R*x
