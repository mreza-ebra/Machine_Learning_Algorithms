function [ logl ] = my_gmmLogLik(X, Priors, Mu, Sigma)
%MY_GMMLOGLIK Compute the likelihood of a set of parameters for a GMM
%given a dataset X
%
%   input------------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Priors : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu     : (N x K), an NxK matrix corresponding to the centroids mu = {mu^1,...mu^K}
%       o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                    Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%
%   output ----------------------------------------------------------------
%
%      o logl       : (1 x 1) , loglikelihood
%%


% Auxiliary Variables
[N, M] = size(X);
[~, K] = size(Mu);

% for i=1:K
%     prob(i) = my_gaussPDF(X, Mu(:,i), Sigma(:,:,i));
%     logl(i)=sum(log(prob(i)));
% end
prob=zeros(K,M);
for i=1:K
    prob(i,:) = my_gaussPDF(X, Mu(:,i), Sigma(:,:,K));
    prob(i,:) = Priors(i).* prob(i,:);
    logl=sum(log(prob));
end
logl=sum(logl);



end

