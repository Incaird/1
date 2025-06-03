% PENDULUM_PHASE  Compute and plot the phase portrait of a simple pendulum.
%
%   This script computes the Hamiltonian vector field for a simple pendulum
%   and integrates sample trajectories to illustrate the phase portrait. The
%   Hamiltonian of the pendulum with unit mass, unit length, and unit gravity
%   is
%
%       H(\theta,p) = 0.5*p.^2 + (1 - cos(\theta)).
%
%   The Hamiltonian equations of motion are
%
%       d\theta/dt =  p
%       dp/dt      = -sin(\theta).
%
%   Running this script will display a quiver plot of the vector field and a
%   set of trajectories in the (\theta,p) plane.

% Grid for phase space
theta = linspace(-pi, pi, 25);
p     = linspace(-3, 3, 25);
[TH, P] = meshgrid(theta, p);

% Hamiltonian vector field
TH_dot = P;               % dtheta/dt
P_dot  = -sin(TH);        % dp/dt

figure;
quiver(TH, P, TH_dot, P_dot, 'k');
hold on;

% Integrate sample trajectories using ode45
traj_theta0 = [-pi, -3*pi/4, -pi/2, -pi/4, 0, pi/4, pi/2, 3*pi/4, pi];
traj_p0     = [-2, 0, 2];

for th0 = traj_theta0
    for p0 = traj_p0
        [t, x] = ode45(@pendulum_ode, [0 10], [th0; p0]);
        plot(x(:,1), x(:,2), 'r');
    end
end

xlabel('\theta');
ylabel('p');
title('Phase portrait of the simple pendulum');
axis tight;
hold off;

%% ODE function for the pendulum Hamiltonian system
function dxdt = pendulum_ode(~, x)
    dxdt = [ x(2);           % dtheta/dt = p
            -sin(x(1)) ];   % dp/dt = -sin(theta)
end
