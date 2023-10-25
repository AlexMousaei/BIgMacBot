function robotStep(obj, event)

    global UR3Bot Paths currentPath currentStep patties;

    global robotFigure personmove personHandle personPosition T2;

    figure(robotFigure)

    % If person should move
    if personmove
        deltaMovement = [0, 0.1, 0];  % Moving in the pos y direction
        personPosition = personPosition + deltaMovement;

        if ~exist('personHandle', 'var')
            personHandle = PlaceObject('personMaleCasual.ply', personPosition);
            T2 = trotz(-pi/2);
            RotateObject(personHandle, T2);
        else
            delete(personHandle);  % Remove the previous model
            personHandle = PlaceObject('personMaleCasual.ply', personPosition);
            RotateObject(personHandle, T2);
        end

        % Check for intersections with the light curtain
        vertices = get(personHandle, 'Vertices');
        for v = 1:size(vertices, 1)
            vertex = vertices(v, :);
            isTriggered = checkLightCurtain(vertex, [3, 0, 1], [-3, 0, 1]);
            if isTriggered
                disp('Intersection detected!');
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

                % Reset step and move to next path
                patties.pattyModel{1}.base = patties.pattyFinalSE3Transform{1};
                patties.pattyModel{1}.animate(0);
                drawnow();

                currentStep = 1;
                currentPath = currentPath + 1;
            end

        case 3
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{2}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{2}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                currentStep = currentStep + 1;
            else
                patties.pattyModel{2}.base = patties.pattyFinalSE3Transform{2};
                patties.pattyModel{2}.animate(0);
                drawnow();
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end

        case 4
            if currentStep <= size(Paths{currentPath}, 1)
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
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
