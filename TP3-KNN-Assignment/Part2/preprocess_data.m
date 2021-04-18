function [X, Y, rk] = preprocess_data(table_data, ratio, data_type)
%PREPROCESS_DATA Preprocess the data in the adult dataset
%
%   input -----------------------------------------------------------------
%
%       o table_data    : (M x N), a cell array containing mixed
%                         categorical and continuous values
%       o ratio : The pourcentage of M samples to extract 
%
%   output ----------------------------------------------------------------
%       o X : (N-1, M*ratio) Data extracted from the table where
%             categorical values are converted to integer values
%       o Y : (1, M*ratio) The label of the data to classify. Values are 1
%             or 2
%       o rk : (N x 1) The range of values for continuous data (will be 0
%               if the data are categorical)

% Auxiliary Variables
M=size(table_data,1);
N=size(table_data,2);
rk = zeros(size(table_data,2),1);
idx=randperm(M,floor(ratio*M));
sample_data=table_data(idx,:);
% ADD CODE HERE: Convert features data to numerical values. If the data are 
% categorical first convert them to int values. If the data are continuous 
% store the range in rk.
% HINT: Type of feature data (continuous or categorical) is stored in
% data_type which is boolean cell array (true if continuous). Only select
% the samples based on idx array. Be careful with the input and output 
% dimensions.
X=zeros(floor(M*ratio),N-1);
Y =zeros(1, floor(M*ratio));
for i=1:N
    if isequal(data_type(i),{0})
        if i==N; Y=grp2idx(sample_data{:,i});
        else
          X(:,i)=grp2idx(sample_data{:,i});
        end
    else  
        rk(i)=max(sample_data{:,i})-min(sample_data{:,i});
        X(:,i)=sample_data{:,i};

    end
end
X=X';
Y=Y';

% END CODE
end

