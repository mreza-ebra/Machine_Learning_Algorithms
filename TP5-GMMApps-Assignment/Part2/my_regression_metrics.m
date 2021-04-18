function [MSE, NMSE, Rsquared] = my_regression_metrics( yest, y )
%MY_REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auxiliary Variables
[~, M] = size(y);
MSE=norm(y-yest)^2/M;
Mu=mean(y);
Mu_h=mean(yest);
var_y=norm(y-Mu)^2/(M-1);
var_yh=norm(yest-Mu_h)^2;
NMSE=MSE/var_y;
Rsquared=((y-Mu)*(yest-Mu_h)')^2/(var_yh*(M-1)*var(y));
i=1;

end

