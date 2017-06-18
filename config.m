addpath(genpath('~/Scrivania/Repo/Acoustic-Keylogger/keylogger'))
savepath

training_path = strcat(pwd,'/keylogger/recording/training/dell/'); 
samples_path = strcat(pwd,'/keylogger/recording/samples/dell/');
victim_path = strcat(pwdd, '/keylogger/keylogger/recording/victim/');
victim_recording = 'example-dell.wav';

chosenKeys =   {'a', 'b', 'c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};

numOfCharacters = size(chosenKeys,2);
values = cell(1,numOfCharacters);

% advanced configuration, only if you know what you are doing

training_keys = 100;
sample_keys = 10;
attack_keys = 20;

trainingThreshold = 25;
samplesThreshold = 25;

push_peak_size = 441;