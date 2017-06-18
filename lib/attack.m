function [ output_args ] = attack( net, attackThreshold )
% Extract clicks from the victim's recording
% Get the features
% Feed the features to the network
% Display the results

config

[pushPeak,~] = extractKeyStroke(victim_recording, 'attack',attackThreshold);

keyFeatures = getFeature(pushPeak, 'attack');

results = net(keyFeatures');

resultsToText(results);

end

