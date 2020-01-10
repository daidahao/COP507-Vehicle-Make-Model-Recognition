% Generate profiles for training
%
% Usage:
%       profiles = generate_profiles()
% Returns:
%       profiles    -   A set of training profile structs specifying
%                       features, features_options, 
%                       reduce, reduce_options, 
%                       classifier, classifier_options
function profiles = generate_profiles()
    prof_features = generate_profiles_features();
    prof_dimension = generate_profiles_dimension();
    prof_classifier = generate_profiles_classifier();
    [X, Y, Z] = meshgrid(prof_features, prof_dimension, prof_classifier);
    profiles = merge_structs(X(:), Y(:), Z(:));
end

function structs_merged = merge_structs(x, y, z)
    structs_merged = cell2struct(...
        [struct2cell(x);struct2cell(y);struct2cell(z)],...
        [fieldnames(x);fieldnames(y);fieldnames(z)]...
    );
end

function prof_features = generate_profiles_features()
    opt_lnhs = struct('depth', {1, 2, 3, 4, 5, 6, 7});
    opt_bsurf = struct('t', {500, 1000, 2000, 4000, 8000, 16000, 32000});

    prof_simple = struct('features', 'smg', 'features_options', 0);    
    prof_simple = struct('features', {'raw', 'ser', 'smg'}, 'features_options', 0);
    prof_lnhs = struct('features', 'lnhs', 'features_options', num2cell(opt_lnhs));
    prof_bsurf = struct('features', 'bsurf', 'features_options', num2cell(opt_bsurf));
    
    prof_features = [prof_simple prof_lnhs prof_bsurf];
end

function prof_dimension = generate_profiles_dimension()
    opt_pca = struct('sigma', {70});
    opt_pca = struct('sigma', {50, 60, 70, 80, 90, 95, 99});
    
    prof_none = struct('reduce', 'none', 'reduce_options', 0);
    prof_pca = struct('reduce', 'pca', 'reduce_options', num2cell(opt_pca));
    
    prof_dimension = [prof_none prof_pca];
end

function prof_classifier = generate_profiles_classifier()
    opt_knn = struct('k', {1, 3, 5, 7, 9});
    
    prof_knn = struct('classifier', 'knn', 'classifier_options', num2cell(opt_knn));
    prof_svm = struct('classifier', 'svm', 'classifier_options', 0);
    
    prof_classifier = [prof_knn prof_svm];
end
