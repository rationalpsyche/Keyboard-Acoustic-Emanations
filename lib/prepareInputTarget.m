function [ input,target ] = prepareInputTarget()
% This function prepares the input and target to be used
% by the neural network
% The input consists of a vector with the feature of the keys
% The target tells the network what is the wanted output

config

% Here mode is 'training' since the network is trained
% over all the original recordings
mode = 'training';

% keyDict is a dictionary data structure with characters as keys and the push peak
% of the corresponing character as value, for instance:
% keyDict('a') = pushPeak('a')
%
% featureDict works in the same way but instead of having the raw data of pushPeak
% it holds its extracted features (fft transform)
keyDict = containers.Map(chosenKeys,values);
featureDict = containers.Map(chosenKeys,values);

for i=1:numOfCharacters
    currKey = chosenKeys{i};
    [pushpeak,clickRecognized] = extractKeyAuto(strcat(currKey,'.wav'), mode, trainingThreshold);
    keyDict(currKey) = pushpeak;
    featureDict(currKey) = getFeature(keyDict(currKey), mode);
end

% Now I construct the input as an array with the values of featureDict as
% elements
%  [feature('a'), .., feature('d')]
input = [];

for i=1:numOfCharacters
    input = [input, featureDict(chosenKeys{i})'];
end

% Now I construct the target to tell the network:
% 1) The number of classes for the output, this is numOfCharacters
%
% Basically I train the network over 'a','b','c','d' for instance,
% When I provide to the network the features of an unknown character 'x'
% I will receive as output the probability for 'x' to be in each class
% ('a','b','c' or 'd')
%
% 2) When training the network a relevant number of features is needed,
% around 100, this value is specified by training_keys
%
% Let's see an example:
% with numOfCharacters = 4 ('a','b','c','d')
% and training_keys = 2 we get the following matrix
% 11 00 00 00
% 00 11 00 00
% 00 00 11 00
% 00 00 00 11
%
% I train the network with:
% f(a_1), f(a_2), .. , f(d_1), f(d_2)       f(a) as feature(a)
%
% The network knows that f(a_1), f(a_2) fall in the class 'a'
% The same reasoning applies to the other characters in an analogous way
target = zeros(numOfCharacters,numOfCharacters*training_keys);

for i=1:numOfCharacters
    target(i,(i-1)*training_keys+1:(i-1)*training_keys+training_keys) = ones(1,training_keys);
end

end

