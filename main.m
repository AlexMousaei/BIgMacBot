% Clear MATLAB
clear all;
close all;
clc

% % Close Open COM port Connections for arduino estop
% if ~isempty(instrfind)
%     fclose(instrfind);
%     delete(instrfind);
% end

% Declare Global Variables

global UR3Bot scaraBot Paths currentPath t...
       currentStep patties robotFigure...
       personmove personHandle personPosition...
       isEmergency T2 ;

isEmergency = false;
robotFigure = figure;
personmove = false;
personPosition = [0, -1.5, 0];
T2 = trotz(-pi/2);
%Initialise the Robots
initUR3Pos = transl(0.25, -0.1+1, 0.85);
UR3Bot = LinearUR3(initUR3Pos);
initScaraPos = transl(-1, 0.8, 0.85)*trotz(pi/2);
scaraBot = IRB_910sc(initScaraPos);


% Setup the Timer
% Create a timer to animate the robot
currentStep = 1;
t = timer('ExecutionMode', 'fixedSpacing', 'Period', 0.01, 'TimerFcn', @robotStep);

% Load the environment
wSpace = Workspace();
wSpace.DisplayEnvironment;

% Add in the burger patties
patties = Patty(3);

% Create the E-stopGui
eStopGUI();
% personGUI();
% % Initialise the serial communication and pass the state manager
%s = serialSetup('COM7');

% Set Target Positions

offset = SE3(transl(0,0,0)*trotx(-pi)); % Keep the end-effector pointing down


targetPatty1 = patties.pattyInitialSE3Transform{1}*offset;
targetPan = SE3(transl(-0.250, 1.418, 0.990))*offset;
waypoint1 = SE3(transl(-0.241, 1.355, 1.25))*offset;
targetTray2 = SE3(transl(-0.825, 1.34, 0.972))*offset;
targetPatty2 = patties.pattyInitialSE3Transform{2}*offset;
targetPatty3 = patties.pattyInitialSE3Transform{3}*offset;


% Setup Waypoints for UR3
qUR3Guess1 = deg2rad([-0.07 -172 -55.4 -6.72 -24.9 89.5 6.41 6.41]); % Tray 1 q config UR3
qUR3Guess2 = deg2rad([-0.54 -172 -33.1 2.88 -24.9 89.5 6.41 6.41]); % Waypoint 1 q config UR3
qUR3Guess3 = deg2rad([-0.54 -172 -63.6 2.88 -24.9 89.5 6.41 6.41]); % Pan q config UR3
qUR3Guess4 = deg2rad([-0.80 -135 -65.6 2.88 -24.9 89.5 6.41 6.41]); % Tray 2 q config UR3
qScaraGuess1 = deg2rad([157, 0, -0.18]); % Tray q config Scara
qScaraGuess2 = deg2rad([215, 0, -0.15]);

% Setup the Robot Paths
qUR3Start = UR3Bot.model.getpos();
qUR3Pick1 = UR3Bot.model.ikcon(targetPatty1, qUR3Guess1);
qUR3WayPt1 = UR3Bot.model.ikcon(waypoint1, qUR3Guess2);
qUR3Place1 = UR3Bot.model.ikcon(targetPan, qUR3Guess3);
qUR3Place2 = UR3Bot.model.ikcon(targetTray2, qUR3Guess4);
qUR3Pick2 = UR3Bot.model.ikcon(targetPatty2, qUR3Guess1);

qScaraStart = scaraBot.model.getpos();

qPath1 = jtraj(qUR3Start, qUR3Pick1, 100);
qPath2 = jtraj(qUR3Pick1, qUR3WayPt1, 100);
qPath3 = jtraj(qUR3WayPt1, qUR3Place1, 100);
qPath4 = jtraj(qUR3Place1, qUR3WayPt1, 100); % wait to cook here
qPath5 = jtraj(qUR3WayPt1, qUR3Place1, 100);
qPath6 = jtraj(qUR3Place1, qUR3WayPt1, 100);
qPath7 = jtraj(qUR3WayPt1, qUR3Place2, 100);
qPath8 = jtraj(qUR3Place2, qUR3Pick2, 100);

% qPath9 = jtraj(qScaraStart, qScaraPick1, 100);
% qPath10 = jtraj(qScaraStart, qScaraPick1, 100);
% qPath11 = jtraj(qScaraPick1, qScaraPlace1, 100);

Paths = {qPath1, qPath2, qPath3...
        ,qPath4, qPath5, qPath6...
        ,qPath7, qPath8};

currentPath = 1;

input("Press enter to continue: ", 's');
start(t);





