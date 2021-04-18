function [F1_overall, P, R, F1] =  my_f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (N x 1),  N-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (N x 1),  N-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auxiliary Variables
M         = length(class_labels);
true_K    = unique(class_labels);
found_K   = unique(cluster_labels);
nClasses  = length(true_K);
nClusters = length(found_K);
c=zeros(nClasses,1);
k=zeros(nClusters,1);

% Output Variables
P = zeros(nClasses, nClusters);  %Sorry to change the dimensions :). I transposed it at the end
R = zeros(nClasses, nClusters);
F1 = zeros(nClasses, nClusters);
F1_overall = 0;

for i=1:nClasses
    n=(class_labels==true_K(i));
    c(i)=sum(n);
    for j=1:nClusters
        t=(cluster_labels==found_K(j));
        k(j)=sum(t);
        l=(n==t)&(n==1);
        nik=sum(l);
        R(i,j)=nik/c(i);
        P(i,j)=nik/k(j);
        
        if (nik==0) %both R and P are zero
            F1(i,j)=0;
        else
            F1(i,j)=2*R(i,j)*P(i,j)/(R(i,j)+P(i,j));
        end
    end
    f(i)=(c(i)/M)*max(F1(i,:),[],2);
end
P=P';
R=R';
F1=F1';
F1_overall=sum(f);


end
