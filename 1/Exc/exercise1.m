clc;
clear;
close all;

%% Visualize data coming from a dataset

% load the iris dataset and store it in two arrays meas and species
load fisheriris
featuresLabel = {'Sepal length','Sepal width','Petal length','Petal width'};

% plot the repartition of data for each fetures
figure('Name', 'Boxplots')
univariateBoxplot(meas, species, featuresLabel)

% plot the scatter matrix of the data
figure('Name', 'Scatter matrix')
scatterMatrix(meas, featuresLabel, species)

% plot the samples only considering sepal length and petal width
figure('Name', 'Sepal length versus petal width')
axis = [1,4];
plot2DSamples(meas, species, featuresLabel, axis);

% plot the samples only considering sepal width and sepal length
figure('Name', 'Sepal width versus sepal length')
axis = [2,1];
plot2DSamples(meas, species, featuresLabel, axis);

% plot the histogram for petal length
figure('Name', 'Histogram of Petal length')
axis = 2;
plot2DSamples(meas, species, featuresLabel, axis);