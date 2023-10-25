function isTriggered = checkLightCurtain(point, lineStart, lineEnd)
    % Tolerance for floating-point comparisons
    tol = 1e-6;
    thresholdDistance = 0.1;  % Threshold for checking closeness to the light curtain

    % Find the closest point on the line segment to the given point
    t = dot(point - lineStart, lineEnd - lineStart) / dot(lineEnd - lineStart, lineEnd - lineStart);
    t = max(0, min(1, t));  % Clamp t to the range [0, 1]
    closestPoint = lineStart + t * (lineEnd - lineStart);

    % Calculate the distance between the given point and the closest point on the line segment
    distance = norm(point - closestPoint);

    % If the distance is below the threshold, the light curtain is triggered
    if distance < thresholdDistance
        isTriggered = true;
        return;
    end

    % If we reach this point, the light curtain has not been triggered
    isTriggered = false;
end
