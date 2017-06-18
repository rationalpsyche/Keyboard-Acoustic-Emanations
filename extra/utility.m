clear
clc
config

[network_input, network_target] = prepareInputTarget();

%% 
verbose = 0;
hiddenLayerSize = evaluateNetwork(network_input, network_target, verbose);

%% 
hiddenLayerSize = 100;
net = neuralNetwork(network_input,network_target,hiddenLayerSize); 

%%

displayResults(net);

%%

testNetworkAgainstSamples(net);
