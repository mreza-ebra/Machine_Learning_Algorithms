function [X_train, Y_train, X_test, Y_test] = kFoldSplit(X, Y, k, roundNumber, seed)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Re-apply the seed
rng(seed)

% Encode the Y vector (each label corresponding to an int)
Y = grp2idx(Y);

% Calculate the number of elements
nbSamples = size(X, 1);

% suffle X and Y
ix = randperm(nbSamples);
X = X(ix,:);
Y = Y(ix,:);

% calculate the fold size from the value of k
foldSize = nbSamples / k;

% divide X and Y into k folds
X = reshape(X, k, foldSize, size(X, 2));
Y = reshape(Y, k, foldSize, size(Y, 2));

% select the test set corresponding to the roundNumber
X_test = reshape(X(roundNumber,:,:), foldSize, size(X, 3));
Y_test = reshape(Y(roundNumber,:,:), foldSize, size(Y, 3));

% take the rest as train set
X = X([1:roundNumber-1,roundNumber+1:end],:,:);
Y = Y([1:roundNumber-1,roundNumber+1:end],:,:);
X_train = reshape(X, nbSamples-foldSize, size(X,3));
Y_train = reshape(Y, nbSamples-foldSize, size(Y,3));
end

