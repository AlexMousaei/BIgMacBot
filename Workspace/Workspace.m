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
        benchFile
        tray1File
        tray2File
        tray3File
        burgerFile
        sauce1File
        sauce2File
        counterFile
        % Setup Handles for the objects in the environment
        floorHandle
        tableHandle
        personHandle
        fenceHandle
        fireHydrantHandle
        eStopHandle
        kitchenBenchtopHandle
        panHandle
        benchHandle
        tray1Handle
        tray2Handle
        tray3Handle
        burgerHandle
        sauce1Handle
        sauce2Handle
        counterHandle
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
            self.benchFile = 'workBench2.ply';
            self.tray1File = 'tray.ply';
            self.tray2File = 'tray.ply';
            self.tray3File = 'tray.ply';
            self.burgerFile = 'burger.ply';
            self.sauce1File = 'ketchup.ply';
            self.sauce2File = 'ketchup.ply';
            self.counterFile = 'counter.ply';

        end
        
        function DisplayEnvironment(self)
            global robotFigure;
            figure(robotFigure);

            % Display the floor
            self.floorHandle = surf([-4,-4;4,4], ...
                                    [-4,4;-4,4], ...
                                    [0.01,0.01;0.01,0.01], ...
                                    'CData', imread(self.floorTexture), ...
                                    'FaceColor', 'texturemap');
            hold on;

            % Set up light curtain
            lightCurtainStart = [3, 0, 1];
            lightCurtainEnd = [-3, 0, 1];
            plot3([lightCurtainStart(1), lightCurtainEnd(1)], [lightCurtainStart(2), lightCurtainEnd(2)], [lightCurtainStart(3), lightCurtainEnd(3)], 'r--', 'LineWidth', 2);

            
            % Display the table
            tablePosition = [-0.45, 0.75, 0]; 
            self.tableHandle = PlaceObject(self.tableFile, tablePosition);
        
            personPosition = [1.25, 2.45, 0];
            self.personHandle = PlaceObject(self.personFile, personPosition);
            T2 = trotz(pi/2);
            RotateObject(self.personHandle, T2);

            % % Display the Safety features in environment
            % fencePosition = [0, 2.25, -1];
            % self.fenceHandle = PlaceObject(self.fenceFile, fencePosition);
            % %Scale down object
            % vertices1 = get(self.fenceHandle, 'vertices');
            % scalingFactor = 0.65;
            % scaledVertexData1 = vertices1 * scalingFactor;
            % set(self.fenceHandle, 'Vertices', scaledVertexData1);

            fireHydrPosition = [2.25, -2, 0.5];
            self.fireHydrantHandle = PlaceObject(self.fireHydrantFile, fireHydrPosition);
            T3 = trotz(pi);
            RotateObject(self.fireHydrantHandle, T3);

            eStopPosition = [1.0, -2, 1.05];
            self.eStopHandle = PlaceObject(self.eStopFile, eStopPosition);
            % T4 = trotz(pi);
            T4 = trotx(pi/2);
            RotateObject(self.eStopHandle, T4);
            
            kitchenPosition = [0, 0.75+1, 0];
            self.kitchenBenchtopHandle = PlaceObject(self.kitchenBenchtopFile,kitchenPosition);
            
            panPosition = [-0.22, 0.72+1, 1.015];
            self.panHandle = PlaceObject(self.panFile,panPosition);
            
            %final patty
            tray1Position = [-1.1, 0.4+1, 0.93];
            self.tray1Handle = PlaceObject(self.tray1File,tray1Position);
            
            %burger? tray
            tray3Position = [-1.1, 0.4+1+0.4, 0.93];
            self.tray3Handle = PlaceObject(self.tray3File,tray3Position);
            
            %initial patty
            tray2Position = [0.2, 0.55+1-0.2, 1];
            self.tray2Handle = PlaceObject(self.tray2File,tray2Position);
            RotateObject(self.tray2Handle, T3);

            % Display the table
            benchPosition = [-1.75, 1.3, 0]; 
            self.benchHandle = PlaceObject(self.benchFile, benchPosition);
            T5 = trotz(pi/2);
            RotateObject(self.benchHandle, T5);
            
            burgerPosition = [-1.85, 0.8, 0.85];
            self.burgerHandle = PlaceObject(self.burgerFile,burgerPosition);
            % 
            % sauce1Position = [-0.7, 0.4+1, -1.1];
            % self.sauce1Handle = PlaceObject(self.sauce1File,sauce1Position);
            % 
            % sauce2Position = [-1.25, 0.63+1, -1.1];
            % self.sauce2Handle = PlaceObject(self.sauce2File,sauce2Position);

            counterPosition = [0.5,-2.9,0.01];
            self.counterHandle = PlaceObject(self.counterFile,counterPosition);
            Tcounter = trotz(-pi/2);
            RotateObject(self.counterHandle,Tcounter);
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