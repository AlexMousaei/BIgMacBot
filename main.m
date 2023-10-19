clear all;
clc
close all;

%Initialise the Robots
initUR3Pos = transl(0, -0.1, 0.85);
UR3Bot = LinearUR3(initUR3Pos);
initScaraPos = transl(-1.75, 0.9, 0.85);
scaraBot = IRB_910(initScaraPos);

% Load the environment
wSpace = Workspace();
wSpace.DisplayEnvironment;

% Close Open COM port Connections for arduino estop
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

% start logging
diary('outputLog.txt');
diary on;
logMessage('STARTING');
hold on;

% add environment set up

% Initialize the state manager
stateMgr = StateManager();
% Initialise the serial communication and pass the state manager
s = serialSetup('COM7', stateMgr);

r1 = LinearUR3();
NewRobotBaseTr = transl(-1.25,0.4,0);
r2 = IRB_910sc();





% Log that the main control loop has started
logMessage('Main robot control loop started.');


% Robot control loop
while true




    % Check the emergency stop flag
    if stateMgr.getState() == State.EmergencyStop
        % Handle the emergency stop, e.g., safely halt robot operations
        logMessage('Main loop halted due to emergency stop.');

    end
    if stateMgr.getState() == State.Active
        % Handle the emergency stop, e.g., safely halt robot operations
        logMessage('active.');

    end
    if stateMgr.getState() == State.Idle
        % Handle the emergency stop, e.g., safely halt robot operations
        logMessage('idle.');

    end
    if stateMgr.getState() == State.Resume
        % Handle the emergency stop, e.g., safely halt robot operations
        logMessage('resume.');

    end

    % ...  robot control code here ...

    pause(1)

end

% Cleanup the serial connection
fclose(s);
delete(s);
clear s;

% Log that the main control script has ended
logMessage('Main script ended.');

