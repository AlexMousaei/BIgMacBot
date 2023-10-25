function robotStep(obj, event)
    global UR3Bot Paths currentPath currentStep patties;

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
                currentStep = 1;
                currentPath = currentPath + 1;
            end
            
        % Add more cases as needed for more paths
        
        otherwise
            % If all trajectories are done, stop the timer
            if currentPath > length(Paths)
                stop(obj);
            end
    end
end
