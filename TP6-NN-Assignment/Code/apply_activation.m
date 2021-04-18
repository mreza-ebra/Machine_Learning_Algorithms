function [res] = apply_activation(Z, Sigma, isForward)
%APPLY_ACTIVATION Summary of this function goes here
%   Detailed explanation goes here

switch Sigma
    
     case 'sigmoid'
         if isForward
             res=sigmf(Z,[1 0]);
         else 
             res=sigmf(Z,[1 0]).*(ones(size(Z))-sigmf(Z,[1 0]));
         end
           
     case 'tanh'
         if isForward
             res=tanh(Z);
         else
             res=ones(size(Z))-tanh(Z).^2;
         end

     case 'relu'
         if isForward
             res=max(Z,0);
         else
             res=(Z>=zeros(size(Z)));
         end
         
    case 'softmax'
        C=max(Z,[],1);
        res=exp(Z-C)./sum(exp(Z-C));
                    
end


end

