function [training_score, validation_score] = reduce_dimensionality(training_features, ...
            validation_features, sigma)
    [coeff,scoreTraining,~,~,explained,mu] = pca(training_features);
    sum_explained = 0;
    idx = 0;
    while sum_explained < sigma
        idx = idx + 1;
        sum_explained = sum_explained + explained(idx);
    end
    training_score = scoreTraining(:, 1:idx);
    validation_score = (validation_features - mu) * coeff(:, 1:idx);
end

