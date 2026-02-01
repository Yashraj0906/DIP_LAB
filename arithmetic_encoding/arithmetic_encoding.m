%% Arithmetic Encoding
% Yashraj Kumar
%
% Input: Symbol set with probabilities and input sequence
%
% Output: Encoded interval and representative fractional value

%% Defaults
clc;
clear all;
close all;

%% Inputs, Variables, Constants
charSet      = ["A", "B", "C", "D"];
charProb     = [0.1 0.4 0.2 0.3];
msgSequence  = 'BDACB';

%% Interactive Inputs
%charSet     = input("Enter symbol set in ascending order: ");
%charProb    = input("Enter corresponding probability values: ");
%msgSequence = input("Enter message sequence: ");

%% Algorithm
cumDist = [0 cumsum(charProb)];

lowVal  = 0;
highVal = 1;

fprintf('Initial range: [%.6f , %.6f)\n\n', lowVal, highVal);

for n = 1:length(msgSequence)
    pos = find(charSet == msgSequence(n));
    
    % Width of current interval
    width = highVal - lowVal;
    
    % Compute new interval
    lowNext  = lowVal  + width * cumDist(pos);
    highNext = lowVal  + width * ...
               (cumDist(pos) + charProb(pos));
    
    % Update bounds
    lowVal  = lowNext;
    highVal = highNext;
    
    fprintf('After %c : [%.6f , %.6f)\n', ...
            msgSequence(n), lowVal, highVal);
end

%% Results
fprintf('\nEncoded range for the message "%s" is: [%f , %f)\n', ...
        msgSequence, lowVal, highVal);

finalCode = (lowVal + highVal) / 2;
fprintf('Assigned average value for the message is: %f\n', finalCode);
