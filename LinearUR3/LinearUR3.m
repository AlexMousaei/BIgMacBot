% Class: LinearUR3
% Purpose: Defines a UR3 robot mounted on a linear rail.
% Inherits from: ModifiedRobotBaseClass
classdef LinearUR3 < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'LinearUR3';
    end

    methods
        %% Constructor
        function self = LinearUR3(baseTr)
            if nargin < 1 % Nothing passed
                baseTr =  eye(4);
                logMessage('Using default LinearUR3 base transform. \n');
            else 

            end
            logMessage('Creating Model. \n');
            self.CreateModel();
            self.model.base = self.model.base.T * baseTr * trotx(pi/2) * troty(pi/2);
            self.PlotAndColourRobot();
            drawnow();
        end
        %% Create the robot model
        function CreateModel(self)
            % Create the UR3 model mounted on a linear rail
            % dist = 0.0398+0.08654;
            link(1) = Link([pi     0       0       pi/2    1]); % PRISMATIC Link
            % link(1) = Link([pi     0       0       0    1]); % PRISMATIC Link
            link(2) = Link('d',0.1519,'a',0,'alpha',pi/2,'qlim',deg2rad([-360 360]), 'offset',0);
            link(3) = Link('d',0,'a',-0.24365,'alpha',0,'qlim', deg2rad([-90 90]), 'offset',-pi/2);
            link(4) = Link('d',0,'a',-0.21325,'alpha',0,'qlim', deg2rad([-170 170]), 'offset', 0);
            link(5) = Link('d',0.11235,'a',0,'alpha',pi/2,'qlim',deg2rad([-360 360]),'offset', -pi/2);
            link(6) = Link('d',0.08535,'a',0,'alpha',-pi/2,'qlim',deg2rad([-360,360]), 'offset',0);
            link(7) = Link('d',0.0819,'a',0,'alpha',0,'qlim',deg2rad([-360,360]), 'offset', 0);
            %link(8) = Link('d',0.1500,'a',0,   'alpha',0,   'offset',0,'qlim',deg2rad([-360,360]));

            % Incorporate joint limits
            link(1).qlim = [-0.81 -0.01];
            % link(1).qlim = [0.01 0.81];
            
            % Create robot
            self.model = SerialLink(link,'name',self.name);
        end

    end
end