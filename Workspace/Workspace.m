classdef Workspace < handle
    properties(Access = public)
        plyFileNameStem = 'KitchenParts'
        % Setup the file properties
        floorTexture
        tableFile
        personFile
        fenceFile
        fireHydrantFile
        eStopFile
        kitchenBenchtopFile
        panFile
        
        % Setup Handles for the objects in the environment
        floorHandle
        tableHandle
        personHandle
        fenceHandle
        fireHydrantHandle
        eStopHandle
        kitchenBenchtopHandle
        panHandle
    end
    
    methods
        % Constructor to build object
        function self = Workspace()
            hold on;
            self.floorTexture = "concrete.jpg";
            self.tableFile = 'workBench.ply';
            self.personFile = 'personMaleCasual.ply';
            self.fenceFile = 'fenceEnclosure.ply';
            self.fireHydrantFile = 'fireExtinguisherElevated.ply';
            self.eStopFile = 'emergencyStopWallMounted.ply';
            self.kitchenBenchtopFile = 'kitchenWorkspace.ply';
            self.panFile = 'fryingpan.ply';

        end
        
        function DisplayEnvironment(self)
            % Display the floor
            self.floorHandle = surf([-3,-3;3,3], ...
                                    [-3,3;-3,3], ...
                                    [0.01,0.01;0.01,0.01], ...
                                    'CData', imread(self.floorTexture), ...
                                    'FaceColor', 'texturemap');
            hold on;
            
            % Display the table
            tablePosition = [-0.15, -0.25, 0]; 
            self.tableHandle = PlaceObject(self.tableFile, tablePosition);
            %T1 = trotz(pi);
            %RotateObject(self.tableHandle, T1)
            % Display Persons
            personPosition = [1.25, 1.45, 0];
            self.personHandle = PlaceObject(self.personFile, personPosition);
            T2 = trotz(pi/2);
            RotateObject(self.personHandle, T2);

            % Display the Safety features in environment
            fencePosition = [0, 1, -1];
            self.fenceHandle = PlaceObject(self.fenceFile, fencePosition);
            %Scale down object
            vertices1 = get(self.fenceHandle, 'vertices');
            scalingFactor = 0.65;
            scaledVertexData1 = vertices1 * scalingFactor;
            set(self.fenceHandle, 'Vertices', scaledVertexData1);

            fireHydrPosition = [-2.8, -0.422, 0.5];
            self.fireHydrantHandle = PlaceObject(self.fireHydrantFile, fireHydrPosition);
            T3 = trotz(pi/2);
            RotateObject(self.fireHydrantHandle, T3);

            eStopPosition = [-2.0, -1.12, 0.65];
            self.eStopHandle = PlaceObject(self.eStopFile, eStopPosition);
            T4 = trotz(pi);
            RotateObject(self.eStopHandle, T4);
            
            kitchenPosition = [0, 0.75, 0];
            self.kitchenBenchtopHandle = PlaceObject(self.kitchenBenchtopFile,kitchenPosition);
            
            panPosition = [-0.22, 0.72, 1.05];
            self.panHandle = PlaceObject(self.panFile,panPosition);
            

        end

        function DeleteEnvironment(self)
            % Delete the floor
            if isvalid(self.floorHandle)
                delete(self.floorHandle);
            end
            
            % Delete the table
            if isvalid(self.tableHandle)
                delete(self.tableHandle);
            end
            
            % Delete the person
            if isvalid(self.personHandle)
                delete(self.personHandle);
            end

            % Delete the fence
            if isvalid(self.fenceHandle)
                delete(self.fenceHandle);
            end
        end
    end
end