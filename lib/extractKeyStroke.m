function [pushPeak,clickRecognized, keys] = extractKeyStroke(fileName, mode, threshold)
% This function computes the fft over a 'moving window', for each window
% the value of the bins are summed and if they are above a certain
% threshold it means that we have a key stroke
%
% When I meet an index j for which the binSums(j) is above the threshold
% then I extract the sound knowing in advance the length which is 4410
%
% Remark: of course the threshold is strongly dependent on the window size

config

% Here I set some variables according to training or sample mode
if strcmp(mode,'training')
    filePath = strcat(training_path,fileName);
    maxClicks = training_keys;
elseif strcmp(mode,'samples')
    filePath = strcat(samples_path,fileName);
    maxClicks = sample_keys;
elseif strcmp(mode,'attack')
    filePath = strcat(victim_path,fileName);
    maxClicks = attack_keys; % to be modified as function of average click per minute
else
    'Wrong mode specified'
end

[y,Fs] = audioread(filePath); % y is the actual data, 2 because there are two channels

rawSound = transpose(y(:,1));

% I want to discard the first second of recording since there is 'noise'
% due to the microphone turned up
rawSound = rawSound(1,44100:size(rawSound,2));


% I define the size of the window meaning the range of values in which
% I will compute the FFT
winSize = 40;
winNum = floor(size(rawSound,2)/winSize);
clickSize = 44100*0.08; % 44100 Hz * 0.08 seconds



% Here I will place in position j-th the sum of all the bins
% for the j-th window
binSums = zeros(1,winNum);


for i=0:(winNum-1)
    currentWindow = fft(rawSound(1,1+winSize*i:winSize*(i+1)));
    for j=1:size(currentWindow,2)
        binSums(i+1) = binSums(i+1)+abs(currentWindow(1,j));
    end
end


% If I keep the window small I will have more accurate results
% since the range in which the noise is summed up is smaller
% Of course I obtain multiple times values that are above the threshold
% so I need to consider just the first one for every interval corresponding
% to a key stroke length
% A key stroke or click lasts for 0.1 seconds approximately
% The sampling is at 44100 so there are 4410 values in a Click
%
% binSums(i) is the sum of the bins within the i-th windows
% clickPositions(j) contains the beginning index of the j-th click
% When do binSums(i) and binSums(i+k) belong to different clicks?
% when the difference k*winSize > 4410


clickPositions = zeros(1,maxClicks);
j = 1;
offsetToNextClick = ceil(clickSize/winSize);
h = 1;

while (h < size(binSums,2) && j <= maxClicks)
    if (binSums(h) > threshold)
        clickPositions(j) = h*winSize;        
        j = j+1;
        
        % I just need the first index corresponding to the click start
        % so I adjust 'i' to avoid considering the other binSums within
        % the click duration
        h = h+offsetToNextClick;
        
    else
        h = h+1;
    end
    
end

% Let's see how many individual clicks were recognized
k = 1;
clickRecognized = 0;
while (k<=size(clickPositions,2))
    if (clickPositions(k)~=0)
        clickRecognized = clickRecognized+1;
    end
    k = k+1;
end

% Here I actually extract the key strokes

numOfClicks = clickRecognized;
keys = zeros(numOfClicks,clickSize);


for i=1:numOfClicks
    if clickPositions(i) ~= 0
        startIndex = clickPositions(i)-100; % REMARK: -100 otherwise I get only the hit peak without touch peak
        endIndex = startIndex+clickSize-1; % -1 to have exactly 4410 values
        if startIndex > 0 && endIndex < size(rawSound,2)
            keys(i,:) = rawSound(1,startIndex:endIndex);
        end
    else
        '0 value'
    end
end

% Now, from the whole key stroke I just want the push peak which last 10ms
% hence there are 441 values in it

pushPeak = zeros(numOfClicks,push_peak_size);
for i=1:numOfClicks
    pushPeak(i,:) = keys(i,1:push_peak_size);
end

end