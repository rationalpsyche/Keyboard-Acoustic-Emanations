function [ hiddenLayerSize ] = evaluateNetwork( input, target, verbose )
% This functions loops until certain conditions on the number of I,II and III type errors are met.
% At each iteration the number of hidden neurons is incremented.
%
% REMARK: incrementing the number of hidden neurons it not sufficient
% if the conditions on the errors are too restrictive so beware not to get
% caught in a loop. It is more a utility function for the developer to
% have a rough idea on the number of hidden neurons.
% In my case for instance I set it to 10 for 'a','b','c','d' while
% to 100 for the entire alphabet.
tic

config

hiddenLayerSize = 25;
incrementStep = 10;

working = true;

% the initial values is used to avoid having the samples
% satisfying the condition in examineErros because they are initialized to 1
initialValue = 3;

e1_samples = initialValue*ones(1,numOfCharacters);
e2_samples = initialValue*ones(1,numOfCharacters);
e3_samples = initialValue*ones(1,numOfCharacters);
        
while working
    if (examineErrors(e1_samples,e2_samples,e3_samples,numOfCharacters) == 1)
        working = false;
    else
        net = neuralNetwork(input,target,hiddenLayerSize);
        
        % For each click I test how many samples are recognized. 
        % For each click I count the number of I,II, and III type errors 
        % in the recognition of the click.
        % Then I compute their average and I use it as a statistics to evaluate
        % when the network performance is improving
        

        for i=1:numOfCharacters
            if (verbose == 1)
                fprintf('Detection results for %c\n',chosenKeys{i})
            end
            
            currSample = extractKeyAuto(strcat(chosenKeys{i},'.wav'), 'samples',samplesThreshold);
            currSampleFeature = getFeature(currSample,'samples');
            results = net(currSampleFeature');
            
            [e1,e2,e3] = errorTypes(results,i, verbose);

            e1_samples(1,i) = e1;
            e2_samples(1,i) = e2;
            e3_samples(1,i) = e3;

            if (verbose == 1)
                fprintf('\n')
                fprintf('  I type: %d\n', e1)
                fprintf(' II type: %d\n', e2)
                fprintf('III type: %d\n', e3)
            end
        end

        fprintf('\n')
        fprintf('Hidden layers: %d\n',hiddenLayerSize)
        
        hiddenLayerSize = hiddenLayerSize+incrementStep;
    end
end

fprintf('\n')
fprintf('Hidden layers: %d\n',hiddenLayerSize)
fprintf('e1_samples:\n')
disp(e1_samples)
fprintf('e2_samples:\n')
disp(e2_samples)
fprintf('e3_samples:\n')
disp(e3_samples)

fprintf('Finished.\n')
toc

end

