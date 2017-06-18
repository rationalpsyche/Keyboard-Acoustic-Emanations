function [ output_args ] = findAttackThreshold(attackThreshold)

config


filePath = strcat(victim_path,victim_recording);
threshold = attackThreshold;


[y,Fs] = audioread(filePath); % y is the actual data, 2 because there are two channels

rawSound = transpose(y(:,1));

% I want to discard the first second of recording since there is 'noise'
% due to the microphone turned up
rawSound = rawSound(1,44100:size(rawSound,2));


% I define the size of the window meaning the range of values in which
% I will compute the FFT
winSize = 40;
winNum = floor(size(rawSound,2)/winSize);

% Here I will place in position j-th the sum of all the bins
% for the j-th window
binSums = zeros(1,winNum);


for i=0:(winNum-1)
    currentWindow = fft(rawSound(1,1+winSize*i:winSize*(i+1)));
    for j=1:size(currentWindow,2)
        binSums(i+1) = binSums(i+1)+abs(currentWindow(1,j));
    end
end

x = 1:winNum;
thr = threshold*ones(1,winNum);
plot(x,binSums,x,thr,'r')
xlabel('windows (fixed intervals)')
ylabel('Sum of FFT coefficients')


end

