function personGUI()
   
    % Create figure and button
    f = figure('Name', 'personGUI', 'NumberTitle', 'off', 'Position', [100, 100, 200, 100]);
    btnHandle = uicontrol('Style', 'pushbutton', 'String', 'Press to run', ...
                    'Position', [100, 50, 200, 100], ...
                    'Callback', @lightCurtain);
end