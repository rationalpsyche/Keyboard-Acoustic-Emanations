function [ pushPeak, clickRecognized, keys ] = extractKeyAuto( fileName, mode, threshold)
% This functions aims at extracting the clicks from a recording
% with the highest threshold possible.
% It loops starting with a user defined threshold, if less than `expectedClicks`
% are recognized then the threshold is decrement by 1.
config

if strcmp(mode,'training')
    expectedClicks = training_keys;
    displayOutput = 1;
elseif strcmp(mode,'samples')
    expectedClicks = sample_keys;
    displayOutput = 0;
elseif strcmp(mode,'attack')
    expectedClicks = attack_keys;
    displayOutput = 1;
else
    'Wrong mode specified'
end    

working = true; % boolean value for using `do while`

while working
    [pushPeak,clickRecognized,keys] = extractKeyStroke(fileName, mode, threshold);
    if clickRecognized == expectedClicks
        if displayOutput
            disp(sprintf('%d clicks recognized for %s with threshold %d',clickRecognized, fileName, threshold))
        end
        working = false;
    end

    threshold = threshold-1;
end

end

