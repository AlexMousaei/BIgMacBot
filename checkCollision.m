function isCollision = checkCollision(robot, objectVertices, threshold)
    % Initialize an array to store the joint positions
    jointPositions = zeros(robot.model.n, 3);
    q = robot.model.getpos();
    % Loop through each joint
    for i = 1:robot.model.n
        % Calculate the forward kinematics up to joint 'i'
        T = robot.model.fkine(q, i);
        
        % Extract the XYZ position for joint 'i'
        jointPositions(i, :) = T.t';
    end

    % Check for collision
    isCollision = false;
    for v = 1:size(objectVertices, 1)
        vertex = objectVertices(v, :);
        for j = 1:size(jointPositions, 1)
            if norm(vertex - jointPositions(j, :)) < threshold
                isCollision = true;
                return;
            end
        end
    end
end
