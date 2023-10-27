
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

global UR3Bot scaraBot Paths currentPath t currentStep patties ;

global robotFigure personmove personHandle personPosition T2;
robotFigure = figure;
personmove = false;
personPosition = [0, -1.5, 0];
T2 = trotz(-pi/2);
%Initialise the Robots
initUR3Pos = transl(0, -0.1+1, 0.85);
UR3Bot = LinearUR3(initUR3Pos);
initScaraPos = transl(-1, 1.05, 0.85)*trotz(pi/2);
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

offset = SE3(transl(0,0,0)*trotx(-pi));


targetPos1 = patties.pattyInitialSE3Transform{1}*offset;
targetPos2 = patties.pattyInitialSE3Transform{2}*offset;
waypoint1 = SE3(transl(0.15, 1.3, 1.3))*offset;
targetPos3 = patties.pattyFinalSE3Transform{2}*offset;
targetPos4 = patties.pattyInitialSE3Transform{3}*offset;
targetPos5 = transl(-1.08, 1.90, 0.93); % tray 3 patty pos



% Setup Waypoints for UR3
qUR3Guess1 = deg2rad([-0.01 -180 -70 -15 0 90 0]); % Tray 1 q config UR3
qUR3Guess2 = deg2rad([-0.25 -175 -74 -10 0 90 0]); % Pan q config UR3
qUR3Guess3 = deg2rad([-0.8 -131 -90 0 9 90 0]); % Tray 2 q config UR3
qScaraGuess1 = deg2rad([157, 0, -0.18]); % Tray q config Scara
qScaraGuess2 = deg2rad([215, 0, -0.15]);
% Setup the Robot Paths
qUR3Start = UR3Bot.model.getpos();
qUR3Pick1 = UR3Bot.model.ikcon(targetPos1, qUR3Guess1);
qUR3Place1 = UR3Bot.model.ikcon(targetPos2, qUR3Guess2);
qUR3Place2 = UR3Bot.model.ikcon(targetPos3, qUR3Guess3);
qUR3Pick2 = UR3Bot.model.ikcon(targetPos4, qUR3Guess1);

qScaraStart = scaraBot.model.getpos();
qScaraPick1 = scaraBot.model.ikcon(targetPos2, qScaraGuess1);
qScaraPlace1 = scaraBot.model.ikcon(targetPos5, qScaraGuess2);

qPath1 = jtraj(qUR3Start, qUR3Pick1, 100);
qPath2 = jtraj(qUR3Pick1, qUR3Place1, 100);
qPath3 = jtraj(qUR3Place1, qUR3Place2, 100);
qPath4 = jtraj(qUR3Place2, qUR3Pick2, 100);
qPath5 = jtraj(qScaraStart, qScaraPick1, 100);
qPath6 = jtraj(qScaraPick1, qScaraPlace1, 100);

Paths = {qPath1, qPath2, qPath3, qPath4, qPath5, qPath6};
currentPath = 1;

input("Press enter to continue: ", 's');
start(t);





