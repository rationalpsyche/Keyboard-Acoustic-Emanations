clear
clc
config

file1 = 'a.wav';
file2 = 'f.wav';
mode = 'samples';

if strcmp(mode, 'samples') 
    currentThreshold = samplesThreshold;
    numberOfKeys = sample_keys;
elseif strcmp(mode,'training')
    currentThreshold = trainingThreshold;
    numberOfKeys = training_keys;
else
    fprintf('Wrong mode specified!\n')
end

[pushpeak1,clickRecognized1] = extractKeyAuto(file1, mode, currentThreshold);
[pushpeak2,clickRecognized2] = extractKeyAuto(file2, mode, currentThreshold);

feature1 = getFeature(pushpeak1,mode);
feature2 = getFeature(pushpeak2,mode);

x = 1:push_peak_size;
meanDistance = 0;

for i=1:numberOfKeys
    i
    plot(x,feature1(i,:),x, feature2(i,x))
    distance=dynamicTimeWarping(feature1(i,:),feature2(i,:))
    xlabel(['Distance: ', num2str(round(distance))])
    
    meanDistance = meanDistance+distance;
    drawnow
    pause(2)
    
end

meanDistance = meanDistance/numberOfKeys
fprintf('Finished\n')

