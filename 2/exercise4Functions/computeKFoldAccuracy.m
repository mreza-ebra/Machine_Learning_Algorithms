function [modelAccuracy] = computeKFoldAccuracy(models, modelIndex, X, Y, nbFolds, seed)
%COMPUTEKFOLDACCURACY Summary of this function goes here
%   Detailed explanation goes here

% loop through all the folds
for iter=1:nbFolds
    % divide the dataset in k fold and set the i-th fold as test set 
    [xTrain, yTrain, xTest, yTest] = kFoldSplit(X, Y, nbFolds, iter, seed);
    
    % train the model on the train folds
    model = models{modelIndex}(xTrain, yTrain);
    
     % predict the labels based on test set data
    predictedLabels = model.predict(xTest);
    
    % compute the accuracy
    modelAccuracy(iter) = computeAccuracy(yTest, predictedLabels); 
end

% compute the mean of the accuracies of each folds
modelAccuracy = mean(modelAccuracy);

end

