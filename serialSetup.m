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
    s.BytesAvailableFcn = {@myCallbackFunction};

    % Initialise the state
    % s.UserData.isEmergency = false;

    % Log that callback has been set
    logMessage('Serial estop successful setup');
end

function myCallbackFunction(obj, ~)
    % MYCALLBACKFUNCTION Handles incoming data from the Arduino.
    %   The function reads messages from the Arduino. Depending on the message,
    %   a flag 'emergencyStop' is set or cleared.

    % Read the incoming data
    data = fscanf(obj);

    % Log the received data
    % logMessage('Received: %s', data);

    % Process the received data
    % logic is handled in the toggleStop function
    if contains(data, 'STOP')

        toggleStop('serialSTOP', []);

    elseif contains(data, 'RUN')

        toggleStop('serialRUN', []);

    end

end
