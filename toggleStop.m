function toggleStop(src, event)
    global t isEmergency personmove estopBtnHandle ResumebtnHandle;

    if isa(src, 'matlab.ui.control.UIControl')  % GUI source
        switch src.Tag
            case 'emergency'
                if strcmp(t.Running, 'on')
                    stop(t);
                    eStopBtnHandle.BackgroundColour = [0.8 0.2 0.2];
                    isEmergency = true;
                else
                    eStopBtnHandle.BackgroundColour = [0.2 0.6 0.2];
                    isEmergency = false;
                    
                end
            case 'resume'
                if isEmergency == false;
                        start(t); 
                end
            case 'person'
                personmove = true;
            otherwise
                warning('Unknown UIControl callback source');
        end
    elseif isa(src, 'serial')  % Serial port source
        handleSerialCallback();
    elseif strcmp(src, 'lightcurtaindetection')  % Custom string source
        handleLightCurtainDetection();
    else
        warning('Unknown callback source');
    end
end

function handleSerialCallback()
    global t;
    global btnHandle;
    logMessage('Serial Button Pressed');
    toggleTimerAndButton();
end

function handleLightCurtainDetection()
    global t;
    global btnHandle;
    logMessage('lightcurtaindetection');
    toggleTimerAndButton();
end

function toggleTimerAndButton()
    global t;
    global btnHandle;
    if strcmp(t.Running, 'on')
        stop(t);
        btnHandle.String = 'Resume';  % Update the GUI button string
        logMessage('GUI string changed to resume');
    else
        start(t);
        btnHandle.String = 'E-Stop';  % Update the GUI button string
        logMessage('GUI string changed to estop');
    end
end

function logMessage(msg)
    disp(msg);
end

