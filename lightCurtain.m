function lightCurtain(hObject, eventdata)

    global robotFigure; % Use the global variable to get the handle

    figure(robotFigure); % Set the 'robotFigure' as the current figure


    % Light curtain line
    lightCurtainStart = [3, 0, 1];
    lightCurtainEnd = [-3, 0, 1];
    plot3([lightCurtainStart(1), lightCurtainEnd(1)], [lightCurtainStart(2), lightCurtainEnd(2)], [lightCurtainStart(3), lightCurtainEnd(3)], 'r--', 'LineWidth', 2);

    personPosition = [0, -1.5, 0];
    personHandle = PlaceObject('personMaleCasual.ply', personPosition);
    T2 = trotz(-pi/2);
    RotateObject(personHandle, T2);

    % Define the movement vector
    deltaMovement = [0, 0.1, 0];  % Moving in the pos y direction
    numSteps = 50;  % Number of animation steps

    % Animation loop
    for step = 1:numSteps
        % Move the person model
        personPosition = personPosition + deltaMovement;
        delete(personHandle);  % Remove the previous model
        personHandle = PlaceObject('personMaleCasual.ply', personPosition);
        RotateObject(personHandle, T2);

        % Get the updated vertices of the person model
        vertices = get(personHandle, 'Vertices');

        % Check for intersections with the light curtain
        for v = 1:size(vertices, 1)
            vertex = vertices(v, :);

            % Call your function to check intersection with light curtain
            isTriggered = checkLightCurtain(vertex, lightCurtainStart, lightCurtainEnd);

            if isTriggered
                % Handle the intersection (e.g., display a message)
                disp('Intersection detectected!');
                toggleStop('lightcurtaindetection', []);

                % Optional: stop the animation
                return;
            end
        end

        % Redraw the figure
        drawnow;
    end
end