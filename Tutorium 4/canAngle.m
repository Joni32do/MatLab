function [distance, duration, data] = canAngle(a0)
v0 = 100;
r = 0.1;
wx = 10;
wy = 0;
dt = 0.01;

[distance, duration, data] = cannonball_shot(v0,a0,r,wx,wy,dt,1,1);

end