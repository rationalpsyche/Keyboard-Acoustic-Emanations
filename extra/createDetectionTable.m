function [ absoluteDetectionRate ] = createDetectionTable( results, indexOfCurrKey )
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

firstDetection = 0;
secondDetection = 0;
thirdDetection = 0;

for j=1:sample_keys
    currentColumn = results(:,j);
    
    [~,idx] = sort(currentColumn,'descend');
    
    % idx(1) is the index corresponding to the maximum element in the column
    % idx(2) is the index corresponding to the second maximum
    % idx(3) is the index corresponding to the third maximum
    % 
    % if the index idx(h) (h being 1,2, or 3) is equal to i then the key we are considering has been 
    % correctly detected and the respective counter is incremented

    if idx(1) == indexOfCurrKey
        firstDetection = firstDetection+1;
    elseif idx(2) == indexOfCurrKey
        secondDetection = secondDetection+1;
    elseif idx(3) == indexOfCurrKey
        thirdDetection = thirdDetection+1; 
    end
end

fprintf('%c: %d, %d, %d\n',chosenKeys{indexOfCurrKey},firstDetection,secondDetection,thirdDetection)

end

