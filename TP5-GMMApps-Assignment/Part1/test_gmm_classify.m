%% DO NOT MODIFY THIS UNLESS YOU ARE ON YOUR OWN COMPUTER
addpath(genpath("C:\Program Files\MATLAB\toolbox\ML_toolbox-master"))
addpath(genpath("~/Repositories/ML_toolbox/")) % TODO CHANGE FOR
%WINDOWS LOCATION

addpath(genpath("../utils"))

clear; 
close all; 
clc;

dataset_path = '../../TP5-GMMApps-Datasets/';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) GMM-Classification 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ADD CODE HERE
% Load a dataset, and train GMM models
% You can use any of the dataset functions provided in the 
% dataset folder in utils
M=2000; minx=10; r1=15; r2=25; noise=5; ratio=0.6;
data = halfkernel(M, minx, r1, r2, noise, ratio);
X=data(:,(1:2))';
N=size(X,1);
Y=grp2idx(data(:,3))';
Nclass=length(unique(Y));

validSize=0.4;
[Xtrain, Ytrain, Xtest, Ytest] = split_data(X, Y, validSize);

params.cov_type = 'full';
params.k = 4;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'random';


models = GMM_train(Xtrain, Ytrain, params,Nclass);

%% END CODE

% visualize the GMM fitting
figure('Name', 'Original dataset')
dotsize = 12;
scatter(data(:,1), data(:,2), dotsize, data(:,3)); axis equal;

% Display contours for each class
for c = 1:length(unique(Y))
    ml_plot_gmm_pdf(Xtrain, models(c).Priors, models(c).Mu, models(c).Sigma)
    hold off 
end

%% ADD CODE HERE
% Perform classification on the testing set
y_est = gmm_predict(Xtest, params.k,models,Nclass);



%% END CODE 

% Compute Accuracy
acc =  my_accuracy(Ytest, y_est);

% visualize it
figure('Name', 'Classification with GMM')
ax1 = subplot(1,2,1);
dotsize = 12;
scatter(data(:,1), data(:,2), dotsize, data(:,3)); axis equal;
title('Original Data');

% Plot decision boundary
ax2 = subplot(1,2,2);
plot_boundaries(Xtrain, Ytrain, Xtest, Ytest, y_est,  models, params.k);
linkaxes([ax1,ax2],'xy')