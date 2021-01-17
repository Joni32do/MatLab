%testScript

%Today we might not even create a live scipt, even tough I really like the
%visualisation by it, this format will be sufficent


%Creating randomdata:
n = 300;
xi = 2*rand(n,1)-1;
yi = 2*rand(n,1)-1;
zi = gauss(xi,yi);




m = 300;
xj = 2*rand(m,1)-1;
yj = 2*rand(m,1)-1;
zj = inv_dist(xi,yi,zi,xj,yj,2,'loopIJ')


plot3(xi,yi,zi, 'ro');

hold on

plot3(xj,yj,zj, 'bo');

hold off