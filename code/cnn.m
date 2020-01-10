% Train a CNN model for VMMR tasks, following our proposed
% architecture

clear; clc;
% Path to the pre-processed dataset folder
config.dataset_path = '../dataset';
% Resolution for scaling
config.resolution = [140,140];
scale_fcn = @(x) imresize(imread(x), config.resolution, 'bilinear');
% Number of images per class for training
config.num_train_imgs_per_model = 6;
% Read images into a imageDatastore
dataset = imageDatastore(config.dataset_path,...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames',...
     'ReadFcn', scale_fcn...
);
% Set seed for random generator to constant
% in order to get consistent results
config.s = rng(1);
% Split dataset into training and validation sets
[training_set, validation_set] = splitEachLabel(dataset, config.num_train_imgs_per_model, 'randomize');

% Build a simple CNN model
layers = [
    imageInputLayer([140 140 1],"Name","imageinput")
    convolution2dLayer([5 5],32,"Name","conv_1","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_1")
    maxPooling2dLayer([3 3],"Name","maxpool_1","Padding","same","Stride",[2 2])
    convolution2dLayer([3 3],32,"Name","conv_2","Padding","same","Stride",[2 2])
    reluLayer("Name","relu_2")
    maxPooling2dLayer([3 3],"Name","maxpool_2","Padding","same","Stride",[2 2])
    fullyConnectedLayer(256,"Name","fc_1")
    reluLayer("Name","relu_4")
    dropoutLayer(0.5,"Name","dropout")
    fullyConnectedLayer(27,"Name","fc_2")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

% Options for training
options = trainingOptions('adam', ...
    'MiniBatchSize',20, ...
    'MaxEpochs',200, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',validation_set, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the CNN model
netTransfer = trainNetwork(training_set,layers,options);