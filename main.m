
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

global UR3Bot scaraBot qPath1 qPath2 qPath3 qPath4 Paths currentPath t currentStep patties;

global robotFigure;
robotFigure = figure; % Create the robot figure

%Initialise the Robots
initUR3Pos = transl(0, -0.1+1, 0.85);
UR3Bot = LinearUR3(initUR3Pos);
initScaraPos = transl(-1.55, 1.6, 0.85);
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
personGUI();
% % Initialise the serial communication and pass the state manager
% s = serialSetup('COM7');

% Set Target Positions

offset = SE3(transl(0,0,0)*trotx(pi));


targetPos1 = patties.pattyInitialSE3Transform{1}*offset;
targetPos2 = patties.pattyInitialSE3Transform{2}*offset;
targetPos3 = patties.pattyFinalSE3Transform{2}*offset;
targetPos4 = patties.pattyInitialSE3Transform{3}*offset;


% Setup Waypoints for UR3
qGuess1 = deg2rad([-0.01 -180 -30 -15 0 90 0]); % Tray 1 q config
qGuess2 = deg2rad([-0.32 -180 -30 -15 0 90 0]); % Pan q config
qGuess3 = deg2rad([-0.69 -135 -30 -15 0 90 0]); % Tray 2 q config

qStart = UR3Bot.model.getpos(); 
qPick1 = UR3Bot.model.ikcon(targetPos1, qGuess1);
qPlace1 = UR3Bot.model.ikcon(targetPos2, qGuess2);
qPlace2 = UR3Bot.model.ikcon(targetPos3, qGuess3);
qPlace3 = UR3Bot.model.ikcon(targetPos4, qGuess1);

qPath1 = jtraj(qStart, qPick1, 150);
qPath2 = jtraj(qPick1, qPlace1, 150);
qPath3 = jtraj(qPlace1, qPlace2, 150);
qPath4 = jtraj(qPlace2, qPlace3, 150);
Paths = {qPath1, qPath2, qPath3, qPath4};
currentPath = 1;



input("Press enter to continue: ", 's');
start(t);





