%This generates a JPG Picture of a plot as requested

X = linspace(-10,10,1e2+1);
[X,Y] = meshgrid(X);

Z = f2(X,Y);
droplet = surf(X,Y,Z+0.5,"EdgeColor", 'none');
lightangle(gca,-45,30)
lighting gouraud

hold on

contour(X,Y,Z)

X = linspace(-10,10,25);
[X,Y] = meshgrid(X);
Z = f2(X,Y);
p = pcolor(X,Y,Z);
p.LineWidth = 0.125;
p.LineStyle = 'none';
hold off

print -djpeg
%print droplet –djpeg99 –r600 –opengl Droplet.jpg.