function [ models ] = GMM_train(Xtrain, Ytrain, params,Nclass)
%%
for i=1:Nclass
    r=(Ytrain==i);
    Xt=Xtrain(:,r);
    [models(i).Priors, models(i).Mu, models(i).Sigma, ~,~,~,~] = my_gmmEM(Xt, params);
end