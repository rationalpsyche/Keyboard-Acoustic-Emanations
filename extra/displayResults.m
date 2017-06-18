function [ output_args ] = displayResults(net)
% This function displays the number of I,II,III type errors

config 

for i=1:numOfCharacters
          
        fprintf('\nDetection results for %c\n',chosenKeys{i})

        currSample = extractKeyAuto(strcat(chosenKeys{i},'.wav'), 'samples',samplesThreshold);
        currSampleFeature = getFeature(currSample,'samples');
        results = net(currSampleFeature');


        [e1,e2,e3] = errorTypes(results,i, verbose);

        fprintf('\n')
        fprintf('  I type: %d\n', e1)
        fprintf(' II type: %d\n', e2)
        fprintf('III type: %d\n', e3)

end


end

