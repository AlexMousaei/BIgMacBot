clear all;
clc
close all;



% start logging
diary('outputLog.txt');
diary on;
logMessage('STARTING');
hold on;

% environment set up



r1 = LinearUR3();
NewRobotBaseTr = transl(-1.25,0.4,0);
r2 = NewRobot(NewRobotBaseTr);
