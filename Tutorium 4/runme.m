%Find the best shot

%First we are going to declare the parameters for the environment
v0 = 100;
r = 0.1;
wx = 10;
wy = 0;
dt = 0.01;


%And lastly we can choose our angle, which we will take diffrent values
a0 = 30;

result = cannonball_shot(v0,a0,r,wx,wy,dt,1,1);

%Since im to lazy to type this everytime im going to create a wrapper

result = canAngle(a0);

%Now we can play around with it a little bit
figure('Name','Some Angles');

for i = 0:10:90
    canAngle(i); 
end

%Nun ist es ein leichtes (wenn wir uns einfach eine gesunde Anzahl an
%Berechnungen erlauben, mit einem einfachen Zero-Finding Algorithmus den
%weitesten Winkel zu berechnen
figure('Name','Best Angle')

precission = 0.0001; %Maximale differenz zum eigentlichen Idealen Winkel
delta = 0.001;
bestAngle = 42.964;
change = 1;
oldDistance = canAngle(bestAngle);

while abs(change)>delta
    newDistance = canAngle(bestAngle + delta);
    change = newDistance - oldDistance;
    oldDistance = newDistance;
    
    if change > 0
        bestAngle = bestAngle + delta;
    else  
        bestAngle = bestAngle - delta;
    end 
end
%And therefor by pure brute force calculation, we've got
bestAngle,
oldDistance
%But this is awful, now how can we improve.


%It would be nice to vary the step size:
%Increases or decreases the angle in depending on how big the increase is
%To phrase it differently it uses a version of the Newton-Method to solve
%for the roots of the derivative 


figure('Name','Newton Best Angle')

precission = 0.1; %Maximale differenz zum eigentlichen Idealen Winkel
delta = 0.001;
a = 42;
change = 1;
oldDistance = canAngle(bestAngle);

while abs(change)>delta
    l = canAngle(a);
    d = canAngle(a + delta);
    dd = canAngle(a + 2* delta);
    change = l - d;
    factor = (d-l)/(2*d-l-dd) %Calculatet via Newton-Method 2nd deriva
    if change > 0
        a = a + delta*factor;
    else  
        a = a - delta*factor;
    end 
end