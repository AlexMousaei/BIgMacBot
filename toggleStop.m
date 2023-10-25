function toggleStop(src, event)
    global t;
    global btnHandle;  % Declare the global variable
    global personmove

    if isa(src, 'matlab.ui.control.UIControl')  % GUI source
        switch src.Tag
            case 'emergency'
                if strcmp(t.Running, 'on')
                    stop(t);
                    src.String = 'Resume';
                else
                    start(t);
                    src.String = 'E-Stop';
                end
            case 'person'
                personmove = true;
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
    elseif strcmp(src, 'lightcurtaindetection')  % Custom string source
        logMessage('lightcurtaindetection');
        if strcmp(t.Running, 'on')
            stop(t);
            btnHandle.String = 'Resume';  % Update the GUI button string
            logMessage('GUI string changed to resume');
        end
    else
        warning('Unknown callback source');
    end
end
