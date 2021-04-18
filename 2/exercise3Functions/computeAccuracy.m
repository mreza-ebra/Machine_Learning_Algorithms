function [accuracy] = computeAccuracy(groundTruth, predictedLabels)
%COMPUTEACCURACY Summary of this function goes here
%   Detailed explanation goes here

accuracy = 100*mean(predictedLabels == groundTruth);
end

