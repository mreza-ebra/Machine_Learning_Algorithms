function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats  : (1 X 1), # times to repeat k-means
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o init     : (string), type of initialization {'random','uniform','plus'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K \in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K \in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K \in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RSS_curve = zeros(1, length(K_range));
AIC_curve = zeros(1, length(K_range));
BIC_curve = zeros(1, length(K_range));
rss=zeros(repeats,1);
aic=zeros(repeats,1);
bic=zeros(repeats,1);


for k=1:size(K_range,2)
    for i=1:repeats
        [labels, Mu, ~, ~] =  my_kmeans(X,k,init,type,MaxIter,[]);
        [rss(i), aic(i), bic(i)] =  my_metrics(X, labels, Mu);
    end
    RSS_curve(k)=mean(rss);
    AIC_curve(k)=mean(aic);
    BIC_curve(k)=mean(bic);
end


end
