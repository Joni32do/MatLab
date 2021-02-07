function [distance, duration, data] = cannonball_shot(v0,a0,r,wx,wy,dt,plotting,holding)
% CANNONBALL_SHOT does three things:
% (1) it simulates the trajectory of a cannonball
% (2) it computes the shot distance and duration
% (3) on demand, it plots the cannonball trajectory
%
% the trajectory depends on...
% initial velocity      v0          (1000)
% initial angle of shot a0          (45)
% cannonball radius     r           (0.1)
% wind velocity         [wx, wy]    (-10,0)
%
%
% the time step size dt (0.1) controls the accuracy of the simulation
% the flag "plotting" controls whether or not plotting is...
%       1: on for the final result
%       0: off
% the flag "holding" controls whether plot is added to previous plot(s)
% 


% set initial conditions for cannonball
ctrl.t0   = 0;                      % starting time of shot [s]
ctrl.x0   = 0;                      % initial position of cannonball [m]
ctrl.y0   = 0;                      % initial position of cannonball [m]
ctrl.v0   = v0;                     % initial shot velocity [m/s]
ctrl.a0   = a0;                     % initial angle of shot [degrees]

% set problem parameters for cannonball flight
ctrl.g   = 9.81;                       % gravitational constant [m^2/s]
ctrl.rho = 1.225;                      % density of air [kg/m^3]
ctrl.C_d = 0.5;                        % friction coefficient of cannonball [-]
ctrl.r   = r;                          % radius of cannonball [m]
ctrl.A   = pi * ctrl.r^2;              % cross-sectional area of cannonball
ctrl.m   = 8000 * 4/3 * pi * ctrl.r^3; % mass of cannonball (density of steel = 8000 kg/m^3)
ctrl.wx  = wx;                         % wind velocity [m/s] (negative is against shot direction)
ctrl.wy  = wy;                         % wind velocity [m/s] (negative is against shot direction)

% discretization for solving the cannonball ODE
ctrl.dt  = dt;                         % time step size for dinite difference

% compute the cannonball trajectory
[distance,duration,data] = simulate_shot(ctrl);

% plot the cannonball trajectory
if plotting == 1
    if holding == 1
        hold on
        plot(data.x,data.y)
        hold off
    else
        plot(data.x,data.y)
    end
    xlabel('distance from cannon [m]')
    ylabel('height [m]')
    title('cannonball flight with air friction')
    drawnow
end

end % of function cannonball_shot

% -------------------------------------------------
% Subfunction 1: Finite difference shot simulation
% -------------------------------------------------

function [distance,duration,data] = simulate_shot(ctrl)
% SIMULATE_SHOT simulates the trajectory of a cannonball.
% It uses a quadratic law for air friction
% and considers wind against the shot direction
% using this finite difference equation:
%   dv = dt*( g - 1/2 * C_d * rho * A * (v-w).^2 / m)
% where...
%   dv  [m/s]    is a velocity change in time interval dt
%   dt  [s]      is a discrete time for numerical solution of the ODE
%   g   [m/s^2]  is the gravity acceleration vector
%   C_d [-]      is the air friction coefficient of a sphere
%   rho [kg/m^3] is the density of air
%   A   [m^2]    is the cross section of the cannonball
%   m   [kg]     is the mass of the cannonball
%   v   [m/s]    is the velocity of the cannonball
%   w   [m/s]    is the wind velocity
%
% subject to the initial conditions
%   v(t=0) = v0  initial velocity
%   x(t=0) = x0  initial x-position
%   y(t=0) = y0  initial y-position (vertical coordinate)
%   a(t=0) = a0  initial angle of cannonball flight
%
% the shot distance is the distance in x covered by the cannonball
% when it touches the ground surface (y=0). The final time step is
% modifies in such a manner that the cannonball exactly hits the gound
% (and does not numerically go below the ground surface).

% import and initialize variables from the CTRL structure.
% These are the variables that change dynamically
% during the finite difference simulation:
t  = ctrl.t0;           % initial time
x  = ctrl.x0;           % initial x position
y  = ctrl.y0;           % initial y position
a  = ctrl.a0/360*2*pi;  % initial angle

% decompose absolute velocity and angle into velocity components vx, vy:
vx  = ctrl.v0*cos(a);   % initial x-velocity
vy  = ctrl.v0*sin(a);   % initial y-velocity

% let the ball fly until it hits the ground: loop!
while 1==1
    % use current velocities to update position
    x_new = x(end) + vx*ctrl.dt;
    y_new = y(end) + vy*ctrl.dt;
    t_new = t(end) + ctrl.dt;
    
    % append the new position to the history of positions
    % (this is dirty code as it enlarges variables on-the-fly)
    % (but it is a simple solution to output the entire trajectory)
    x = [x x_new];
    y = [y y_new];
    t = [t t_new];
    
    % check termination criterion: did the ball hit the ground?
    if y_new < 0
        % if yes: ensure that last time step is so small
        % that cannonball is not BELOW ground durface!
        dt_back = -y(end)/vy;           % (this is how much to go back in time)
        x(end) = x(end) + vx*dt_back;
        y(end) = y(end) + vy*dt_back;
        t(end) = t(end) + dt_back;
        break % finished: leave the shot simulation
    end
    
    % if cannonball is still flying: update velocities (here: gravity)
    vy = vy - ctrl.g*ctrl.dt;
    
    % update velocities (here: air friction with wind)
    vx_effective = vx - ctrl.wx;
    vy_effective = vy - ctrl.wy;
    v_effective = sqrt(vx_effective^2 + vy_effective^2);
    ax = - 1/2 * ctrl.C_d * ctrl.rho * ctrl.A * vx_effective * v_effective /ctrl.m;
    ay = - 1/2 * ctrl.C_d * ctrl.rho * ctrl.A * vy_effective * v_effective /ctrl.m;
    
    vx = vx + ax * ctrl.dt;
    vy = vy + ay * ctrl.dt;
    
end

% compile output (x,y,t) into DATA structure
data.x   = x;
data.y   = y;
data.t   = t;

% return shot distance as last x position
distance = x(end);
duration = t(end);

end


