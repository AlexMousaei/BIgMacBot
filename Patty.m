% patty Class: This class represents a set of patty and their properties.
% It provides functionality to manage initial and final positions of patty,
% load the patty model and visual representation.
classdef Patty < handle
    properties (Constant)
        % Constants representing the initial and final positions of the patty in the workspace.
        pattyInitialPositions = [ % Initial positions of patty.
            0.175, 0.4, 0;
            0.075, 0.4, 0;
            -0.025, 0.4, 0;
            -0.125, 0.4, 0;
            -0.225, 0.4, 0;
            0.175, -0.4, 0;
            0.075, -0.4, 0;
            -0.025, -0.4, 0;
            -0.125, -0.4, 0;
            ];

        pattyFinalPositions = [ % final positions where the patty should be placed.

        0.4, 0, 0;                  %Bot mid
        0.4, 0.13343, 0;            %Bot left
        0.4, 0,  0.03336;           %mid mid
        0.4, 0.13343,  0.03336;     %mid left
        0.4, 0.13343,  0.06672;     %top left
        0.4, -0.13343, 0;           %Bot right
        0.4, 0,  0.06672            %top mid
        0.4, -0.13343, 0.03336;     %mid right
        0.4, -0.13343, 0.06672;   %top right
        ];

    end

    properties
        pattyCount = 9;             % Number of patty.
        pattyModel;                % 3D Model representation of the patty.
        pattyInitialSE3Transform;  % Transformation matrix of the patty's initial position.
        pattyFinalSE3Transform;    % Transformation matrix of the patty's final position.


    end

    methods
        % Constructor
        function self = Patty(pattyCount)
            if 0 < nargin
                self.pattyCount = pattyCount;
            end
            % Create the required number of patty
            for i = 1:self.pattyCount
                self.pattyModel{i} = self.LoadpattyModel(['patty',num2str(i)]);

                % Convert positions into SE3 transforms
                self.pattyInitialSE3Transform{i} = SE3(self.pattyInitialPositions(i,1),self.pattyInitialPositions(i,2),self.pattyInitialPositions(i,3));
                self.pattyFinalSE3Transform{i} = SE3(self.pattyFinalPositions(i,1),self.pattyFinalPositions(i,2),self.pattyFinalPositions(i,3));
                self.pattyModel{i}.base = self.pattyInitialSE3Transform{i};

                % Plot 3D model
                W = [-2 2 -2 2 -0.25 1];
                plot3d(self.pattyModel{i},0,'workspace',W,'view',[-30,30],'delay',0,'noarrow','nowrist', 'notiles');
                axis equal
                if isempty(findobj(get(gca,'Children'),'Type','Light'))
                    camlight
                end
            end

        end

    end
    methods (Static)
        %% Get patty Model - adapted from "RobotCows"
        function model = LoadpattyModel(name)
            if nargin < 1
                name = 'patty';
            end
            % Read the .ply file which contains the 3D representation of the patty.
            [faceData, vertexData] = plyread('HalfSizedRedGreenpatty.ply', 'tri');
            L1 = Link('alpha', 0, 'a', 0, 'd', 0, 'offset', 0);
            model = SerialLink(L1, 'name', name);

            % Assign face and vertex data to the model.
            model.faces = {[], faceData};
            model.points = {[], vertexData};
        end


    end
end




