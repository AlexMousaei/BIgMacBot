function toggleStop(src, event)
    if isa(src, 'matlab.ui.control.UIControl')  % GUI source
        handleUiControlCallback(src.Tag);
    elseif strcmp(src, 'serialSTOP')   % Custom string source (serial source)
        handleSerialStopCallback();
    elseif strcmp(src, 'serialRUN')   % Custom string source (serial source)
        handleSerialRunCallback();
    elseif strcmp(src, 'lightcurtaindetection')  % Custom string source
        handleLightCurtainDetection();
    elseif strcmp(src, 'collisiondetection')  % Custom string source
        handleForcedCollisionDetection();
    else
        warning('Unknown callback source');
    end
end

function handleUiControlCallback(tag)
    global t isEmergency personmove estopBtnHandle personHandle personPosition...
        objectPosition objectHandle objectForceCollision;
    switch tag
        case 'emergency'
            if isEmergency == false
                stop(t);
                estopBtnHandle.BackgroundColor = [0.8 0.2 0.2];
                isEmergency = true;
                logMessage('Emergency stop activated');
            else
                estopBtnHandle.BackgroundColor = [1, 0.5, 0];
                logMessage('Emergency stop turned off');
                isEmergency = false;

            end
        case 'resume'
            if isEmergency == false
                logMessage('Resume activated');
                start(t);
            else
                logMessage('Turn off emergency stop before continuing');
            end
        case 'person'
            personmove = true;
        case 'deletePerson'
            if isgraphics(personHandle)
                delete(personHandle);
                personHandle = [];
                personPosition = [0, -1.5, 0];
                logMessage('person model deleted');
            else
                logMessage('model does not exist');
            end
        case 'forcedcollision'
            objectForceCollision = true;
        case 'deleteObject'
            if isgraphics(objectHandle)
                delete(objectHandle);
                objectHandle = [];
                logMessage('object model deleted');
            else
                logMessage('model does not exist');
            end
        otherwise
            warning('Unknown UIControl callback source');
    end

end

function handleSerialStopCallback()
    global isEmergency estopBtnHandle;

    if isEmergency == true
        isEmergency = false;
        logMessage('Emergency stop turned off');
        estopBtnHandle.BackgroundColor = [1, 0.5, 0];
    else
        isEmergency = true;
        logMessage('Emergency stop activated');
        toggleTimerAndButton();
        estopBtnHandle.BackgroundColor = [0.8 0.2 0.2]; %red
    end
end

function handleSerialRunCallback()
    global t isEmergency;

    if isEmergency == true
        logMessage('Turn off emergency stop before continuing');
    elseif isEmergency == false
        logMessage('Run activated');
        start(t);

    end
end

function handleLightCurtainDetection()
    logMessage('Sensor Detection: Laser photoelectric beam has been broken!');
    toggleTimerAndButton();
end

function handleForcedCollisionDetection()
    logMessage('Collision Detection: Robot actions stopped to prevent collision')
    toggleTimerAndButton();
end

function toggleTimerAndButton()
    global t isEmergency estopBtnHandle;

    if strcmp(t.Running, 'on')
        stop(t);
        estopBtnHandle.BackgroundColor = [0.8 0.2 0.2]; %red
        isEmergency = true;
    end
end
