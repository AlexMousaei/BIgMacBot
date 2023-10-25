function robotStep(obj, event)
    global UR3Bot Paths currentPath currentStep patties;
 
    if currentStep <= size(Paths{currentPath}, 1) && currentPath == 1
        % Animate the robot for the current trajectory step
        UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
        disp("here");
        drawnow();
        currentStep = currentStep + 1;

    else
        % If current trajectory is done, move to the next
        currentPath = currentPath + 1;
        if currentPath <= length(Paths)
            % Reset current step and start the new trajectory
            currentStep = 1;
            UR3Bot.model.animate(Paths{currentPath}(currentStep, :));
            patties.pattyModel{1}.base = UR3Bot.model.fkine(UR3Bot.model.getpos());
            patties.pattyModel{1}.animate(0);
            disp(UR3Bot.model.getpos());
            drawnow();
            currentStep = currentStep + 1;
        else
            % If all trajectories are done, stop the timer
            stop(obj);
        end
    end
end