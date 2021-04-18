function [y_est,var_est] = my_gmr(Priors, Mu, Sigma, X, in, out,params)
%MY_GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K=size(Mu,2);
% beta=zeros(N,K);
Mux=Mu(in,:);
Muy=Mu(out,:);
Sigmaxx=Sigma(in,in,:);
Sigmaxy=Sigma(in,out,:);
Sigmayx=Sigma(out,in,:);
Sigmayy=Sigma(out,out,:);

P=length(out);
M=size(X,2);
% Mu_til=zeros(K,M);

% for i=1:K
%         prob(i,:) = Priors(i).*my_gaussPDF(X', Mux(:,i), Sigmaxx(:,:,i));
% end
ye=zeros(K,M);
Mu_til=zeros(K,M);
beta = expectation_step(X, Priors, Mux, Sigmaxx, params);
Sigma_til=zeros(K,P,M);
for k=1:K
    Mu_til(k,:)=Muy(:,k)+Sigmayx(:,:,k)*inv(Sigmaxx(:,:,k))*(X-Mux(:,k));
    ye(k,:)=Mu_til(k,:).*beta(k,:);
    Sigma_til(k,:,:)=ones(P,P,M)*(Sigmayy(:,:,k)-Sigmayx(:,:,k)*inv(Sigmaxx(:,:,k))*Sigmaxy(:,:,k));
    O=reshape(Mu_til,K,P,M);
    Y=reshape(ye,K,P,M);
    B=reshape(beta,K,P,M);
    vare(k,:,:)=B(k,:,:).*(O(k,:,:).^2+Sigma_til(k,:,:))-Y(k,:,:).^2;
end

y_est=sum(ye,1);
var_est=sum(vare,1);
var_est=reshape(var_est,P,P,M);
end