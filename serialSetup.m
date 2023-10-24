function s = serialSetup(port)
     % other input stateMgr
    % SETUPSERIAL Initializes a serial connection for communication with Arduino.
    %   s = SETUPSERIAL(port) creates a serial object for the specified port.
    %   The function also sets up the necessary properties and callbacks for the serial object.

    % Create the serial object with specified properties
    s = serial(port,'BaudRate', 9600, 'Terminator', 'LF');

    % Open the serial port for communication
    fopen(s);

    % Log the initiation of the serial connection
    logMessage('Serial connection initialised on port %s.', port);

    % Set the callback function mode to trigger on terminator character
    s.BytesAvailableFcnMode = 'terminator';
    s.BytesAvailableFcn = {@toggleStop};

    % % Initialise the state and the state manager
    % s.UserData.emergencyStop = false;
    % s.UserData.stateMgr = stateMgr;

    % Log that callback has been set
    logMessage('Callback function set for serial data.');
end

% function myCallbackFunction(obj, ~)
%     % MYCALLBACKFUNCTION Handles incoming data from the Arduino.
%     %   The function reads messages from the Arduino. Depending on the message,
%     %   a flag 'emergencyStop' is set or cleared.
% 
%     % Read the incoming data
%     data = fscanf(obj);
% 
%     % Log the received data
%     logMessage('Received: %s', data);
% 
%     % Retrieve the stateMgr instance from UserData
%     stateMgr = obj.UserData.stateMgr;
% 
%     % Process the received data and update the global flag
%     if contains(data, 'STOP')
%         obj.UserData.emergencyStop = true; % Set the flag in the UserData property
%         stateMgr.setState(State.EmergencyStop);
%     elseif contains(data, 'RUN')
%         obj.UserData.emergencyStop = false; % Clear the flag in the UserData property
%         stateMgr.setState(State.Resume);
%     end
% end