function [ absoluteDetectionRate ] = sampleDetectionRate( results, indexOfCurrKey )
% This function tells the detection rate for a single key
% Example:
% results is a table of the form
%   s1 s2  ...    s15
% a
% b
% c
% d
%
% The element in position (i,j) is the probability that sample j is
% recognized as character i

config

wrongDetection = containers.Map(chosenKeys,values);
for i=1:numOfCharacters
    wrongDetection(chosenKeys{i}) = 0;
end

counter = 0;

%results
for j=1:sample_keys
    currentColumn = results(:,j);
    
    % idx is the index corresponding to the maximum element in the column
    % hence the one chosen as detected
    % if the index is equal to i then the key we are considering has been 
    % correctly detected and the counter is incremented
    [p,idx] = max(currentColumn);
    if idx == indexOfCurrKey
        counter = counter+1;
    else
        wrongDetection(chosenKeys{idx}) = wrongDetection(chosenKeys{idx})+1; 
    end
end

absoluteDetectionRate = counter/sample_keys;
disp(sprintf('Detection for %c: %.2f',chosenKeys{indexOfCurrKey},absoluteDetectionRate))

end

