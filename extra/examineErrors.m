function [status] = examineErrors(e1_samples,e2_samples,e3_samples,numOfCharacters)
    status = 1;
   for j=1:numOfCharacters
       if (e1_samples(1,j) > 2 | e2_samples(1,j) > 2)
           status = 0;
           break;
       end
       
end

