function eStopGUI()
    global t;
    global btnHandle; % Declare the global variable
    
    % Create figure and button
    f = figure('Name', 'E-Stop GUI', 'NumberTitle', 'off', 'Position', [100, 100, 200, 100]);
    btnHandle = uicontrol('Style', 'pushbutton', 'String', 'E-Stop', ...
                    'Position', [100, 50, 200, 100], ...
                    'Callback', @toggleStop, ...
                    'Tag', 'emergency');
end