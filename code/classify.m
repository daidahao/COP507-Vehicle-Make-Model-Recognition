% Train a classification model
%
% Usage:
%       mdl = classify(features, labels, profile, config)
% Arguements:
%       features      -   Matrix of features
%       labels        -   True labels
%       profile       -   Training profile
%       config        -   Global configuration
% Returns:
%       mdl    -   a trained cross-validated classification model
function mdl = classify(features, labels, profile, config)
    switch profile.classifier
        case 'svm'
%             options = statset('UseParallel', true);
            mdl = fitcecoc(features, labels, ...
                'Coding', 'onevsall', ...
                'KFold', config.kfold ...
            );
        case 'knn'
            mdl = fitcknn(features, labels,...
                'NumNeighbors', profile.classifier_options.k, ...
                'KFold', config.kfold ...
            );
    end
end