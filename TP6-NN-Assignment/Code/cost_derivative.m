function [dZ] = cost_derivative(Yd, Y, typeCost, typeLayer)
%COST_DERIVATIVE Summary of this function goes here
%   Detailed explanation goes here


switch typeCost

case 'LogLoss'
    
     switch typeLayer
         case 'softmax'
            dZ = Y-Yd; 
         case 'sigmoid'
            dZ = Y-Yd; %since D=1
     end
    
case 'CrossEntropy'
    
    switch typeLayer
         case 'softmax'
            dZ = Y-Yd; 
         case 'sigmoid'
            dZ = Y-Yd; %since D=1
     end
end








end

