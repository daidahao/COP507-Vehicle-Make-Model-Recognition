clear; clc;

% Path to the pre-processed dataset folder
dataset_path = '../dataset';
% Number of training images per class
num_train_imgs_per_model = 6;
% Resolution for scaling
resolution = [140,140];
scale_fcn = @(x) imresize(imread(x), resolution, 'bilinear');

% Set seed for random generator to constant
% in order to get consistent results
s = rng(1);
% Read images into a imageDatastore
imds = imageDatastore(dataset_path,...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames',...
     'ReadFcn', scale_fcn...
);

% Split dataset into training and validation sets
[training_set, validation_set] = splitEachLabel(imds, num_train_imgs_per_model, 'randomize');
% Reuse the previous random generator s
rng(s);
% Extract features from both sets
[training_features, validation_features] = ...
        extract_features(training_set, validation_set, 'raw');
% Reduce dimensionality for features
[training_features, validation_features] = ...
        reduce_dimensionality(training_features, validation_features, 95);
disp(size(training_features));
% Train a classifier
mdl = fitcecoc(training_features, training_set.Labels);
% Cross validation
mdl_cv = crossval(mdl, 'KFold', 10);
% Predict on validation set
pred = predict(mdl, validation_features);
% Calculate accuracy
accuracy = mean(validation_set.Labels == pred);
disp(accuracy);



