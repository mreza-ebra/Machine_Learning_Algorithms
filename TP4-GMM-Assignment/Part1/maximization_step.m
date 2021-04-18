function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

% Additional variables
[N, M] = size(X);
Mu = zeros(N,params.k);
Sigma = zeros(N,N,params.k);
eps = 1e-5;

S=sum(Pk_x,2);
Priors= (S/M)';
nom=(Pk_x*X')';
for i=1:params.k
    Mu(:,i)=nom(:,i)/S(i);
end

switch params.cov_type
    
    case 'full'
        
        for i=1:params.k     
                Sigma(:,:,i)=Pk_x(i,:).*(X-Mu(:,i))*(X-Mu(:,i))'/S(i)+eye(N,N)*eps;
        end
        
    case 'diag'
        
        for i=1:params.k
                Sigma(:,:,i)=diag(diag(Pk_x(i,:).*(X-Mu(:,i))*(X-Mu(:,i))')/S(i))+eye(N,N)*eps;
        end
        
    case 'iso'
        
       for i=1:params.k
                Sigma(:,:,i)=eye(N)*(Pk_x(i,:)*(vecnorm((X-Mu(:,i))).^2)')/(S(i)*N)+eye(N,N)*eps;
        end
    otherwise
        disp('Wrong type of Covariance Matrix')
end

end

