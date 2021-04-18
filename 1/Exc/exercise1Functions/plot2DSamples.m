function [] = plot2DSamples(data, classes, featuresLabel, axis)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% ADD CODE HERE: extract the dimensions given in axis (2 lines)
data=data(:,axis);
featuresLabel=featuresLabel(axis);
% END CODE

% create a different plot depending on the given axis
[r,c] = size(axis);

% different feature case
if (r > 1) || (c > 1)

    % ADD CODE HERE: plot each sample of the three species (1 line)
    % HINT: look for the function gscatter
    gscatter(data(:,1),data(:,2),classes);
    % END CODE

    xlabel(featuresLabel(1));
    ylabel(featuresLabel(2));
    grid on

% histogram case
else
    % set a color for each class
    colors = ['b','g','r'];
    
    % ADD CODE HERE: extract classes names (return an array of the 3 names)
    classNames = unique(classes);
    % END CODE
    
    % ADD CODE HERE: encode the Y vector (each label corresponding to an int)
    classes = grp2idx(classes);
    % END CODE
    
    % plot a different histogram for each class
    for i=1:length(classNames)
        % ADD CODE HERE: extract the indexes corresponding to the i-th class
        indexes = (classes==i);
        % END CODE
        
        % ADD CODE HERE: plot an histogram of the corresponding samples
        
        histogram(data(indexes), 'FaceAlpha', .7, 'FaceColor', colors(i));
        
	% END CODE
        hold on
    end
    
    % add the legend and axis title
    legend(classNames) 
    xlabel(featuresLabel)
    ylabel('Counts')
end
end

