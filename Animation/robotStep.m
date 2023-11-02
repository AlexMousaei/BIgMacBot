function robotStep(obj, event)

    global UR3Bot scaraBot Paths currentPath currentStep patties robotFigure personmove personHandle personPosition T2...
        objectForceCollision objectPosition objectHandle;

    figure(robotFigure)

    % If person should move
    if personmove
        deltaMovement = [0, 0.05, 0];  % Moving in the pos y direction
        personPosition = personPosition + deltaMovement;
        if isempty(personHandle) || ~isgraphics(personHandle)
            logMessage('Person Model Created')
            personHandle = PlaceObject('personMaleCasual.ply', personPosition);
            T2 = trotz(-pi/2);
            RotateObject(personHandle, T2);
        else
            delete(personHandle);  % Remove the previous model
            personHandle = PlaceObject('personMaleCasual.ply', personPosition);
            RotateObject(personHandle, T2);
        end
    end

    % Place object in environment
    if objectForceCollision == true
        if isempty(objectHandle) || ~isgraphics(objectHandle)
            logMessage('Hand put into environnment');
            objectHandle = PlaceObject('hand.ply', objectPosition );
            %[0.25,1.1,1.15]
            %[-0.5,0.9,1.1]
            RotateObject(objectHandle, troty(pi/2));
        end
    end

    if isgraphics(objectHandle)
        vertices = get(objectHandle, 'Vertices');
        collisionThreshold = 0.2;
        %isCollision = checkCollision(scaraBot, vertices, collisionThreshold);
        isCollision = checkCollision(UR3Bot, vertices, collisionThreshold);

        if isCollision
            toggleStop('collisiondetection', []);
            objectForceCollision = false;
            return;
        end
    end


    % Check for intersections with the laser beam
    % Only checking the personhandle
    if isgraphics(personHandle)
        vertices = get(personHandle, 'Vertices');
        for v = 1:size(vertices, 1)
            vertex = vertices(v, :);
            isTriggered = checkLightCurtain(vertex, [3, 0, 1], [-3, 0, 1]);
            if isTriggered
                toggleStop('lightcurtaindetection', []);
                personmove = false;
                return;
            end
        end
    end

    switch currentPath
        case 1
            if currentStep <= size(Paths{currentPath}, 1)
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                currentStep = currentStep + 1;
            else

                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
            end

        case 2
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{1}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{1}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                currentStep = currentStep + 1;
            else
                currentStep = 1;
                currentPath = currentPath + 1;
            end

        case 3
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{1}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{1}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end

        case 4
            if currentStep <= size(Paths{currentPath}, 1)
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 5
            if currentStep <= size(Paths{currentPath}, 1)
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 6
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{1}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{1}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 7
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{1}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{1}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 8
            if currentStep <= size(Paths{currentPath}, 1)
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        otherwise
            % If all trajectories are done, stop the timer
            if currentPath > length(Paths)
                stop(obj);
            end
    end
end
