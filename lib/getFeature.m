function feature = getFeature( key, mode )

config 

if strcmp(mode,'training')
    N = training_keys;
elseif strcmp(mode,'samples')
    N = sample_keys;
elseif strcmp(mode,'attack')
    N = attack_keys;
else
    'Wrong mode specified'
end

feature = abs(fft(key'))';

end

