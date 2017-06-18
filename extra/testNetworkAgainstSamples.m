function [ output_args ] = testNetworkAgainstSamples( net )
% Once the network has been trained I use this function to know how many
% of the 10 samples for each character have been recognized.
config

disp(sprintf('\nTesting network against samples\n'))

for i=1:numOfCharacters
    currSample = extractKeyAuto(strcat(chosenKeys{i},'.wav'), 'samples',samplesThreshold);
    currSampleFeature = getFeature(currSample,'samples');
    %currentDetection = sampleDetectionRate(net(currSampleFeature'),i);
    createDetectionTable(net(currSampleFeature'),i);
end



end

