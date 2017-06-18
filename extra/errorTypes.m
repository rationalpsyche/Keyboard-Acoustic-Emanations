function [ e1,e2,e3 ] = errorTypes( results, correctIdx, verbose)
% Utility function to detect error types in the network results
%
% I type
% The network is confident in detecting a wrong key as correct
%
% II type
% The network detects a wrong key as correct but the second choice
% is the correct one
%
% III type
% The network detects the correct key but with low confidence
% hence prediction perfomance will drop when dealing with noise

config 

highConfidence = 0.6;
lowConfidence = 0.2;

typeI = 0;
typeII = 0;
typeIII = 0;

% iterate over samples
if (verbose == 1)
    for h=1:numOfCharacters
        fprintf('%c    ',chosenKeys{h})
    end
    fprintf('\n')
end

for j=1:sample_keys
    
        currentColumn = results(:,j);
        [maxValue,maxIdx] = max(currentColumn);

        secondMaxValue = 0;
        secondMaxIdx = 0;
        
        % determine second max value
        for i=1:size(currentColumn)
            if currentColumn(i) > secondMaxValue & i ~= maxIdx
                secondMaxValue = currentColumn(i);
                secondMaxIdx = i;
            end
        end
        
        % display max and second max values
        if (verbose == 1)         

            for i=1:size(currentColumn)
                if i == maxIdx | i == secondMaxIdx
                    fprintf('%.2f ',currentColumn(i))
                else
                    fprintf('     ')
                end
            end
            
            fprintf('\n')
 
        end
        
        % compute number of I,II,III type errors        
        
        if maxIdx ~= correctIdx & maxValue > highConfidence
            typeI = typeI+1;
        elseif maxIdx ~= correctIdx & secondMaxIdx == correctIdx
            typeII = typeII+1;
        elseif maxIdx == correctIdx & maxValue < lowConfidence
            typeIII = typeIII+1;
        end
        
        
        
end

e1 = typeI;
e2 = typeII;
e3 = typeIII;


end

