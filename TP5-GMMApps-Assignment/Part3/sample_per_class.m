function [X] = sample_per_class(models, class, nPoints,K)

out = randsrc(1,nPoints,[(1:K); models(class).Priors]);
X = transpose(mvnrnd(models(class).Mu(:,out)',models(class).Sigma(:,:,out)));
    
end
