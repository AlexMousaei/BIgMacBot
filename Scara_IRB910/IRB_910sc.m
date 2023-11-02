% Class: IRB_910sc
% Purpose: Defines a UR3 robot mounted on a linear rail.
% Inherits from: ModifiedRobotBaseClass
classdef IRB_910sc < RobotBaseClass

    properties(Access = public)
        plyFileNameStem = 'IRB_910sc';
    end

    methods
        %% Constructor
        function self = IRB_910sc(baseTr)
            if nargin < 1 % Nothing passed
                baseTr =  eye(4);
                logMessage('Using default IRB_910sc base transform. \n');
            else

            end
            logMessage('Creating Model. \n');
            self.CreateModel();
            self.model.base = baseTr;
            self.PlotAndColourRobot();
            axis([-3.5 3.5 -3.5 3.5 0 3.5]);
            drawnow();
        end
        function CreateModel(self)
            pause(0.001);

            L(1) = Link('d',0.1916,           'a',0.3,        'alpha',0,  'qlim',deg2rad([-140 140]), 'offset',0);
            L(2) = Link('d',0.2577-0.1916,    'a',0.25,       'alpha',0,  'qlim',deg2rad([-150 150]), 'offset',0);
            L(3) = Link([0     0       0       0    1]);

            L(1).qlim = [-360 360]*pi/180;
            L(2).qlim = [-90 90]*pi/180;
            L(3).qlim = [-0.180 0];

            self.model = SerialLink(L,'name',self.name);
        end

    end
end