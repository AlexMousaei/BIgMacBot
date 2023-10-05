function logMessage(message, varargin)
    % This function logs a message with timestamp.

    % Get the timestamp
    ts = datetime('now','Format','dd-MMM-uuuu HH:mm:ss.SSS');

    % Create the formatted message with timestamp
    fullMessage = sprintf('[%s] %s\n\n', string(ts), message);

    % Display the message
    fprintf(fullMessage, varargin{:});
end