function [] = univariateBoxplot(data, classes, featuresLabel)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% extract the number of dimemsions from the data
dim = size(data);

% create a subplot for each features (second dimension) and draw a boxplot
% of the data
for i=1:dim(2)
    subplot(dim(2)/2, dim(2)/2, i)
    
    % ADD CODE HERE: plot the boxplot of the i-th feature (1 line)
    boxplot(data(:,i),classes)
    % END CODE
    
    xlabel('Species')
    ylabel(featuresLabel(i))
end

end

