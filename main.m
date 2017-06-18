clear
clc
config

[network_input, network_target] = prepareInputTarget();

%%

hiddenLayerSize = 100;

net = neuralNetwork(network_input,network_target,hiddenLayerSize);  

%% 

attackThreshold = userInteraction();


%%

attack(net, attackThreshold);