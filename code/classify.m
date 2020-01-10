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
function [mdl, mdl_cv] = classify(features, labels, profile, config)
    switch profile.classifier
        case 'svm'
%             options = statset('UseParallel', true);
            mdl = fitcecoc(features, labels, ...
                'Coding', 'onevsall' ...
            );
        case 'knn'
            mdl = fitcknn(features, labels,...
                'NumNeighbors', profile.classifier_options.k ...
            );
    end
    mdl_cv = crossval(mdl, 'KFold', config.kfold);
end