% Train a model for VMMR tasks, following the architecture of
% our proposed VMMR system.

clear; clc;
addpath('harris');
% Path to the pre-processed dataset folder
config.dataset_path = '../dataset';
% Resolution for scaling
config.resolution = [140,140];
scale_fcn = @(x) imresize(imread(x), config.resolution, 'bilinear');

% Set seed for random generator to constant
% in order to get consistent results
config.s = rng(1);
config.kfold = 5;
% Read images into a imageDatastore
dataset = imageDatastore(config.dataset_path,...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames',...
     'ReadFcn', scale_fcn...
);

% Generate profiles for training
profiles = generate_profiles();

for i = 1:length(profiles)
    % Training results including model, predictions, scores, etc.
    % are stored into "results"
    results(i) = train_profile(dataset, profiles(i), config);
end


function profile = train_profile(dataset, profile, config)
    % Reuse the previous random generator s
    rng(config.s);
    % Extract features from dataset
    features = extract_features(dataset, profile);
    profile.size = size(features);
    disp(profile.size);
    % Reduce dimensionality for features
    [features, profile.mu, profile.coeff] = ...
        reduce_dimensionality(features, profile);
    profile.reduced_size = size(features);
    disp(profile.reduced_size);
    % Train a classifier
    [profile.mdl, profile.mdl_cv] = ...
        classify(features, dataset.Labels, profile, config);
    % Predict on the dataset using k-fold
    profile.pred = kfoldPredict(profile.mdl_cv);
    % Calculate scores
    [profile.accuracy, profile.precision, profile.recall, profile.f1] = ...
        performance_scores(dataset.Labels, profile.pred);
    disp(profile.accuracy);
end

