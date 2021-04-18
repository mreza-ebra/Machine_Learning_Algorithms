function [XNew] = draw_samp(Priors, Mu, Sigma, nbPoints,K)

idx = randsrc(1,nbPoints,[(1:K);Priors]);
XNew = transpose(mvnrnd(Mu(:,idx)',Sigma(:,:,idx)));

end