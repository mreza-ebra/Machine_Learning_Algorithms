function [RSS, AIC, BIC] =  my_metrics(X, labels, Mu)
%MY_METRICS Computes the metrics (RSS, AIC, BIC) for clustering evaluation
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), an Dxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^D
%
%   output ----------------------------------------------------------------
%
%       o RSS      : (1 x 1), Residual Sum of Squares
%       o AIC      : (1 x 1), Akaike Information Criterion
%       o BIC      : (1 x 1), Bayesian Information Criteria
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary Variables
[N, M] = size(X);
[~, K] = size(Mu);
r=zeros(N,1);
B=K*N;

% Compute RSS (Equation 8)
for k=1:K
     for j=1:M
         if k==labels(j)
             r(j)=(norm(X(:,j)-Mu(:,k))^2);
         end
     end
     t(k)=sum(r);
     r=zeros(N,1);
end
     
RSS=sum(t);
AIC=RSS+2*B;
BIC=RSS+B*log(M);
end

