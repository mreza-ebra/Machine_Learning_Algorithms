function [ y_est ] = gmm_predict(Xtest, K,models,Nclass)

sizeTest=size(Xtest,2);
prob=zeros(K,sizeTest);
sump=zeros(Nclass,sizeTest);

for c=1:Nclass
    for k=1:K
        prob(k,:) = my_gaussPDF(Xtest, models(c).Mu(:,k), models(c).Sigma(:,:,k));
    end
    alpha_prob=models(c).Priors*prob;
    alpha_prob(alpha_prob < realmin) = realmin;
    sump(c,:)=-log(alpha_prob);
end

[~,y_est]=min(sump);