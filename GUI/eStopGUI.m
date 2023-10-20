function eStopGUI()
    global t;
    
    % Create figure and button
    f = figure('Name', 'E-Stop GUI', 'NumberTitle', 'off', 'Position', [100, 100, 200, 100]);
    btn = uicontrol('Style', 'pushbutton', 'String', 'E-Stop', ...
                    'Position', [100, 50, 200, 100], ...
                    'Callback', @toggleStop);
end
