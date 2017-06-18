config

[pushPeak,~,keys] = extractKeyAuto(victim_recording, 'attack',attackThreshold);

for i=1:size(keys,1)
    i
    sound(keys(i,:),44100)
    pause(1)
end
