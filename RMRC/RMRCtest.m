% Setup
clear;
close all;
mdl_planar2; % Load a 2-link planar robot
p2.plot([0 0]); % Plot the robot at joint angles [0 0]
% Define Variables
q = [0 0];
T_initial = p2.fkine(q); % Initial pose
T_final = transl(1, 1, 0); % Desired pose
nSteps = 50; % Number of steps
deltaT = 0.05; % Time step
threshold = 0.005; % Singularity threshold
% Initialize variables
q = zeros(nSteps, p2.n);
qd = zeros(nSteps, p2.n);
q(1,:) = [0 0];

% RMRC Loop
for i = 1:nSteps-1
    % Current end-effector pose
    T = p2.fkine(q(i,:));
    
    % Difference between current and desired pose
    deltaX = tr2delta(T, T_final);
    deltaX = deltaX(1:2); % Only consider translational part (x, y)
    
    % Jacobian and its pseudoinverse
    J = p2.jacob0(q(i,:));
    J = J(1:2, :); % Trim Jacobian to only consider x, y translations
    lambda = 0.1; % Damping factor
    J_pseudo = pinv(J); % Use MATLAB's built-in pseudoinverse function
    
    % Compute joint velocities
    qd(i,:) = (J_pseudo * deltaX)';
    
    % Update joint angles
    q(i+1,:) = q(i,:) + qd(i,:) * deltaT;
end



% Plot the motion
for i = 1:nSteps
    p2.animate(q(i,:));
    pause(deltaT);
end
