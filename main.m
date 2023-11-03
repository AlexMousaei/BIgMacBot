% Clear MATLAB
clear all;
close all;


% % Close Open COM port Connections for arduino estop
% if ~isempty(instrfind)
%     fclose(instrfind);
%     delete(instrfind);
% end

% Declare Global Variables

global UR3Bot scaraBot t currentPath...
       currentStep patties robotFigure...
       personmove  personPosition personHandle...
       isEmergency T2 isSecondLoop pattyIndex...
       objectPosition objectHandle objectForceCollision;

pattyIndex = 1;
isSecondLoop = false;
isEmergency = false;
robotFigure = figure;

personmove = false;
personPosition = [0, -1.5, 0];
T2 = trotz(-pi/2); % could delete?
personHandle = [];

objectPosition = [-0.25, 1.4, 1.1];
objectHandle = [];
objectForceCollision = false;

currentPath = 1;

%Initialise the Robots
initUR3Pos = transl(0.25, -0.1+1, 0.85);
UR3Bot = LinearUR3(initUR3Pos);
initScaraPos = transl(-1.27, 1, 0.85)*trotz(pi/2);
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

% Initialise the Robot animation
InitialiseAnimation();

% Create the E-stopGui
eStopGUI();
% personGUI();

% Initialise the serial communication and pass the state manager
% s = serialSetup('COM7');


input("Press enter to continue: ", 's');
start(t);





