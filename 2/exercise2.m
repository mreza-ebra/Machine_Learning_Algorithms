clc;
clear;
close all;
addpath('./exercise1Functions')
addpath('./exercise2Functions')

%% Split a dataset between training and validation sets

% load the iris dataset and store it in two arrays meas and species
load fisheriris
featuresLabel = {'Sepal length','Sepal width','Petal length','Petal width'};

% pourcentage of samples that will be used for validation
validSize = 0.2;

% set a random seed and save it
rng(42, 'twister');
seed = rng;

% split the dataset in train and test set (use trainTestSplit function)
[xTrain, yTrain, xTest, yTest] = trainTestSplit(meas, species, validSize, seed);

% verify your results using assert functions
assert(size(xTrain, 2) == size(meas, 2))
assert(size(xTrain, 1) == size(yTrain, 1))
assert(size(xTrain, 1) == size(meas, 1) * (1-validSize))
assert(size(xTest, 1) == size(yTest, 1))
assert(size(xTest, 1) == size(meas, 1) * validSize)

% best possible tests
assert(isequal(sort([xTrain; xTest]), sort(meas)))
assert(isequal(sort([yTrain; yTest]), sort(grp2idx(species))))

% set a range of valid size to visualize its impact
validSizes = 0.1:0.1:0.9;

figure('Name', 'Train and Test sets')
for i=1:length(validSizes)
    % split the dataset in train and test set (use trainTestSplit function)
    [xTrain, yTrain, xTest, yTest] = trainTestSplit(meas, species, validSizes(i), seed);

    % plot each sample of the three species for the train dataset
    subplot(2,1,1)
    plot2DSamples(xTrain, yTrain, featuresLabel, [1,2]);
    title('Train dataset')

    % plot each sample of the three species for the test dataset
    subplot(2,1,2)
    plot2DSamples(xTest, yTest, featuresLabel, [1,2]);
    title('Test dataset')
    
    % display the current validation size
    disp(join(['validation size: ' num2str(validSizes(i))]))
    
    % this line will pause your script waiting for you to press a key
    % on the next run of the loop it will update your graphs
    pause(1); % remove that line if you don't want your program to stop
end

% remove the last 30 rows of meas and species. This will unbalance the last
% class
shiftNumber = 40;
meas = meas(1:end-shiftNumber,:);
species = species(1:end-shiftNumber,:);

% split the dataset in train and test set
[xTrain, yTrain, xTest, yTest] = trainTestSplit(meas, species, validSize, seed);

% calculate the ratio of virginica flowers in the dataset
virginicaRatio = sum(grp2idx(species) == 3) / size(species,1);

assert(sum(yTrain == 3) / size(yTrain,1) == virginicaRatio)
assert(sum(yTest == 3) / size(yTest,1) == virginicaRatio)
