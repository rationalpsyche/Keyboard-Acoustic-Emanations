function [ recognizedText ] = resultsToText( results )

config
recognizedText = '';

% for i=1:size(results,2)
%     if i < 10
%         fprintf('%d  ',i);
%     else
%         fprintf('%d ',i);
%     end
% end

fprintf('\n\n')

for i=1:size(results,2)
    currentColumn = results(:,i);
    [p,idx] = max(currentColumn);
    currentColumn(idx) = NaN;
    [second_p,second_idx] = max(currentColumn);
    
    fprintf('%c  ',chosenKeys{idx})
    
end

fprintf('\n')

for i=1:size(results,2)
    currentColumn = results(:,i);
    [p,idx] = max(currentColumn);
    currentColumn(idx) = NaN;
    [second_p,second_idx] = max(currentColumn);
    
    fprintf('%c  ',chosenKeys{second_idx})
    
end

fprintf('\n')

end

