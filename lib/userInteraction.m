function [ attackThreshold ] = userInteraction( )
% Display the current threshold over a plot and ask the user to
% insert a new threshold. It loops until a threshold is confirmed

working = true;
attackThreshold = 20;

while working
    findAttackThreshold(attackThreshold);
    newDecision = str2double(inputdlg('Enter 1 to confirm or enter a new threshold'));
    
    if (newDecision == 1)
        working = false;
    else
        attackThreshold = newDecision;
    end

end
end

