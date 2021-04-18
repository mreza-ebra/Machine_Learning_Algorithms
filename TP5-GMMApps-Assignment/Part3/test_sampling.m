%% DO NOT MODIFY THIS UNLESS YOU ARE ON YOUR OWN COMPUTER
addpath(genpath("C:\Program Files\MATLAB\toolbox\ML_toolbox-master"))
addpath(genpath("~/Repositories/ML_toolbox/")) % TODO CHANGE FOR
%WINDOWS LOCATION

addpath(genpath("../utils"))
addpath(genpath("../Part1"))

clear; 
close all; 
clc;

dataset_path = '../../TP5-GMMApps-Datasets/';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) Sampling from 2D Dataset
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbPoints = 1000;
%% ADD CODE HERE
% Load a dataset, and train GMM model and sample nbPoints points from it
data = halfkernel();
X=data(:,(1:2))';
N=size(X,1);
Y=grp2idx(data(:,3))';
Nclass=length(unique(Y));

validSize=0.4;
[Xtrain, Ytrain, Xtest, Ytest] = split_data(X, Y, validSize);

params.cov_type = 'full';
params.k = 10;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'random';


[Priors, Mu, Sigma, ~,~,~,~] = my_gmmEM(Xtrain, params);
XNew = draw_samp(Priors, Mu, Sigma, nbPoints,params.k);


%% END CODE

% plot both the original data and the sampled ones
figure('Name', 'Original dataset')
dotsize = 12;
ax1 = subplot(1,2,1);
scatter(X(1,:), X(2,:), dotsize);
title('Original Data')
ax2 = subplot(1,2,2);
scatter(XNew(1,:), XNew(2,:), dotsize);
title('Sampled Data')
linkaxes([ax1,ax2],'xy')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         2) Sampling from high-dimensional data
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

train_data = csvread('mnist_train.csv', 1, 0);  
nbSubSamples = 2000;
idx = randperm(size(train_data, 1), nbSubSamples);
train_data = train_data(idx,:);

% extract the data
Xtrain = train_data(:,2:end)';
Ytrain = train_data(:,1)';

plot_digits(Xtrain)

p = 40; % in cases you need this, use this value

%% ADD CODE HERE
[V, ~, Mup] = compute_pca(Xtrain);
[A_p, Xtp] = project_pca(Xtrain, Mup, V, p);

params.cov_type = 'full';
params.k = 100;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'random';

[Priors, Mu, Sigma, ~,~,~,~] = my_gmmEM(Xtp, params);
XNew = draw_samp(Priors, Mu, Sigma, nbPoints,params.k);
XHat = reconstruct_pca(XNew, A_p, Mup);

% plot the reconstructed

plot_digits(XHat)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) Sampling from a GMM per class
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ADD CODE HERE
% we can also train different models of GMM for each class of digits
params.cov_type = 'full';
params.k = 20;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

% [V, ~, Mup] = compute_pca(Xtrain);
% [A_p, Xtp] = project_pca(Xtrain, Mup, V, p);
Nclass=length(unique(Ytrain));

Ytrain=Ytrain+1;
%models = my_gmm_models(Xtrain, Ytrain, params);
models = GMM_train(Xtp, Ytrain, params, Nclass);

% sample fron the GMM that are trained on this specific digit
class = 5;
X = sample_per_class(models, class+1, 100,params.k);

% reconstruct the images from the PCA
XHat = reconstruct_pca(X, A_p, Mup);
%% END CODE
% plot the reconstructed
plot_digits(XHat)
