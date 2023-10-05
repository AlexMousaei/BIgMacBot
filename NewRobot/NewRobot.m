% Class: NewRobot
% Purpose: Defines a UR3 robot mounted on a linear rail.
% Inherits from: ModifiedRobotBaseClass
classdef NewRobot < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'NewRobot';
    end

    methods
        %% Constructor
        function self = NewRobot(baseTr)
            if nargin < 1 % Nothing passed
                baseTr =  eye(4);
                logMessage('Using default NewRobot base transform. \n');
            else 

            end
            logMessage('Creating Model. \n');
            self.CreateModel();
            self.model.base = self.model.base.T * baseTr;

            % Enable once ply models are done
            % self.PlotAndColourRobot();
            % Delete when ply models are done
            self.NoPlyModel();
            drawnow();
        end
        %% Create the robot model
        function CreateModel(self)
            % Create the model
            
            link(1) = Link('d',0,'a',0,'alpha',pi/2,'qlim',deg2rad([-360 360]), 'offset',0);
            link(2) = Link('d',0,'a',0.1,'alpha',0,'qlim', deg2rad([-135 135]), 'offset',pi/2);
            link(3) = Link('d',0,'a',0.1,'alpha',0,'qlim', deg2rad([-135 135]), 'offset', 0);
            %not sure how to implement the gripper into this?
            % last link will not be needed if we can figure out the gripper
            link(4) = Link('d',0,'a',0.025,'alpha',0,'qlim',deg2rad([-180 180]),'offset', 0);
               
            % Create robot
            self.model = SerialLink(link,'name',self.name);
        end

        function NoPlyModel(self)
        % workspace = [-4 4 -4 4 -0.05 2];                                       % Set the size of the workspace when drawing the robot
        
        % scale = 0.5;
        
        q = [0, 0.5236, 0.5236, 0.5236];                                                     % Create a vector of initial joint angles
        
        self.model.plot(q,'nobase', 'noarrow','notiles', 'noname');%,'workspace',workspace,'scale',scale);                  % Plot the robot
        self.model.teach(q);
        hold on
        end

    end
end