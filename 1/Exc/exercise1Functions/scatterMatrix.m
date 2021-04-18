function [] = scatterMatrix(data, featuresLabel, classes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% ADD CODE HERE: plot the matrix and keep the arguments to modify axis
% titles (1 line)
[~,A]=gplotmatrix(data,[],classes);
% END CODE

for i=1:length(featuresLabel)
    % ADD CODE HERE: set the y labels (1 line)
    A(i,1).YLabel.String=featuresLabel(i);
    % END CODE
end
for i=1:length(featuresLabel)
    % ADD CODE HERE: set the x labels (1 line)
     A(length(featuresLabel),i).XLabel.String=featuresLabel(i);
    % END CODE
end
end

