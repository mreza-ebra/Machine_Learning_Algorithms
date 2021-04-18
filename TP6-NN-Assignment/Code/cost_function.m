function [C] = cost_function(Yd, Y, type)
%COST_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
M = size(Y,2);
K=size(Yd,1);
C=0;
switch type
    
    case 'LogLoss'
%         for i
        C=-(sum(Yd.*log(Y)+(ones(1,M)-Yd).*log(ones(1,M)-Y)))/M;
    
    case 'CrossEntropy'
%         for k=1:K
            C=-sum(sum(Yd.*log(Y)))/M;
%         end
end

end

