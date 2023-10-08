classdef StateManager < handle
    properties (Access = private)
        currentState State = State.Idle; % Default state using the separate enumeration
    end
    
    methods
        % Constructor
        function obj = StateManager()
            % Default state is set in the property declaration
        end
        
        % Getter for the current state
        function state = getState(obj)
            state = obj.currentState;
        end
        
        % Setter to change the state
        function setState(obj, newState)
            obj.currentState = newState;
            % Log the new state
            logMessage('New State: %s', char(obj.currentState));
        end
    end
end
