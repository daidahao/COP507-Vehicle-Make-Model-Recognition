% Reduce dimensionality of features
%
% Usage:
%       [features_reduced] = reduce_dimensionality(features, profile)
% Arguements:
%       features    -   Matrix of features
%       profile     -   Training profile
% Returns:
%       features_reduced    -   Matrix of features reduced in 
%                               dimensionality
%       mu                  -   Means of features
%       coeff               -   Principal component coefficients
function [score, mu, coeff] = reduce_dimensionality(features, profile)
    if strcmp(profile.reduce, 'none')
        score = features; mu = 0; coeff = ones(size(features, 2)); return;
    end
    [coeff,scoreTraining,~,~,explained,mu] = pca(features);
    sum_explained = 0;
    idx = 0;
    while sum_explained < profile.reduce_options.sigma
        idx = idx + 1;
        sum_explained = sum_explained + explained(idx);
    end
    score = scoreTraining(:, 1:idx);
    coeff = coeff(:, 1:idx);
end

