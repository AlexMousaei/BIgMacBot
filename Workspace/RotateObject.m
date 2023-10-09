function RotateObject(mesh_h,tr)
    vertices = get(mesh_h,'Vertices');
    verticeCount = size(vertices,1);
    
    % Calculated center of the point cloud 
    midPoint = sum(vertices)/verticeCount;
    centeredVertices = vertices - repmat(midPoint,verticeCount,1);
    
    % Rotate the centered vertices
    rotatedVertices = centeredVertices * tr(1:3,1:3);
    
    % Translate the rotated vertices back to their original position
    updatedVertices = rotatedVertices + repmat(midPoint,verticeCount,1);
    
    set(mesh_h,'Vertices',updatedVertices(:,1:3));
end