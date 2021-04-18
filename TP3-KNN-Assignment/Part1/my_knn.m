function [ y_est ] =  my_knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {0,1} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and eventually the parameters for the Gower
%                  similarity measure)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary Variables
[~, M_test]  = size(X_test);
[~, M_train] = size(X_train);
y_est        = zeros(1, M_test);
d=zeros(M_test,M_train);

    
for i=1:M_test
    for j=1:M_train
    d(i,j) =  my_distance(X_test(:,i), X_train(:,j), params);
    end
    [~,I] = sort(d(i,:),2);
    y2=y_train(I);
    yknn=y2(1:params.k);
    z=unique(yknn);
    s=size(z,2);

    for k=1:s
        r=(z(k)==yknn);
        c(k)=sum(r);
    end
    [~,ind]=max(c);
    y_est(i)=z(ind);
end


end