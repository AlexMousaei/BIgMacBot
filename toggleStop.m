function toggleStop(src, event)
    global t;
    global btnHandle;  % Declare the global variable
    
    
    if isa(src, 'matlab.ui.control.UIControl')  % GUI source
        if strcmp(t.Running, 'on')
            stop(t);
            src.String = 'Resume';
        else
            start(t);
            src.String = 'E-Stop';
        end
    elseif isa(src, 'serial')  % Serial port source
        logMessage('Serial Button Pressed');
        if strcmp(t.Running, 'on')
            stop(t);
            btnHandle.String = 'Resume';  % Update the GUI button string
            logMessage('GUI string changed to resume');
        else
            start(t);
            btnHandle.String = 'E-Stop';  % Update the GUI button string
            logMessage('GUI string changed to estop');
        end
    else
        warning('Unknown callback source');
    end
end
