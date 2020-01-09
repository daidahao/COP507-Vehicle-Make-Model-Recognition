function [score] = reduce_dimensionality(features, profile)
    if strcmp(profile.reduce, 'none')
        score = features; return;
    end
    [~,scoreTraining,~,~,explained,~] = pca(features);
    sum_explained = 0;
    idx = 0;
    while sum_explained < profile.reduce_options.sigma
        idx = idx + 1;
        sum_explained = sum_explained + explained(idx);
    end
    score = scoreTraining(:, 1:idx);
end

