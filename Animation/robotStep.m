function robotStep(obj, event)

    global pattyIndex isSecondLoop UR3Bot scaraBot...
           Paths currentPath currentStep patties...
           robotFigure personmove personHandle...
           personPosition T2 qScaraStart qUR3Start...
           verticesAtOrigin burgerHandle;
    
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
    end
    % Check for intersections with the light curtain
    % Only checking the personhandle
    if isgraphics(personHandle)
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
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    drawnow();
                end 
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
            end

        case 2
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{pattyIndex}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{pattyIndex}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    drawnow();
                end    
                currentStep = currentStep + 1;

            else
                currentStep = 1;
                currentPath = currentPath + 1;
            end

        case 3
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{pattyIndex}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{pattyIndex}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
                drawnow();
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    drawnow();
                end
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
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    drawnow();
                end
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
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    tr = scaraBot.model.fkine(scaraBot.model.getpos()).T;        
                    % Apply the transformation to the gripper's vertices
                    transformedVertices = (tr(1:3, 1:3) * verticesAtOrigin' + tr(1:3, 4))';                
                    % Update the gripper's position and orientation
                    set(burgerHandle, 'Vertices', transformedVertices);
                    drawnow();
                end
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 6
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{pattyIndex}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{pattyIndex}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    patties.pattyModel{pattyIndex-1}.base = scaraBot.model.fkine(scaraBot.model.getpos());
                    patties.pattyModel{pattyIndex-1}.animate(0);
                    tr = scaraBot.model.fkine(scaraBot.model.getpos()).T;        
                    % Apply the transformation to the gripper's vertices
                    transformedVertices = (tr(1:3, 1:3) * verticesAtOrigin' + tr(1:3, 4))';                
                    % Update the gripper's position and orientation
                    set(burgerHandle, 'Vertices', transformedVertices);
                    drawnow();
                end
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                % Add more cases as needed for more paths
            end
        case 7
            if currentStep <= size(Paths{currentPath}, 1)
                patties.pattyModel{pattyIndex}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
                patties.pattyModel{pattyIndex}.animate(0);
                UR3Bot.model.animate(Paths{currentPath}(currentStep, :))
                drawnow();
                if isSecondLoop == true
                    scaraBot.model.animate(Paths{currentPath+9}(currentStep, :));
                    drawnow();
                end
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
                scaraBot.model.animate(Paths{currentPath+1}(currentStep, :))
                drawnow();
                currentStep = currentStep + 1;
            else
                % Reset step and move to next path
                currentStep = 1;
                currentPath = currentPath + 1;
                qUR3Start = UR3Bot.model.getpos();
                qScaraStart= scaraBot.model.getpos();
                InitialiseAnimation();
                % Add more cases as needed for more paths
            end
        otherwise
            isSecondLoop = true;
            currentPath  = 1;
            currentStep = 1;
            pattyIndex = pattyIndex + 1;
            % If all trajectories are done, stop the timer
            if currentPath > length(Paths)
                stop(obj);
            end
    end
end
