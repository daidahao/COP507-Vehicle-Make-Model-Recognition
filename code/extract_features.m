function [training_features, validation_features] = ...
    extract_features(training_set, validation_set, features_name)
    switch features_name
        case 'raw'
            training_features = transform_into_features(training_set, @features_raw);
            validation_features = transform_into_features(validation_set, @features_raw);
        case 'smg'
            training_features = transform_into_features(training_set, @features_smg);
            validation_features = transform_into_features(validation_set, @features_smg);
        case 'lnhs'
            training_features = transform_into_features(training_set, @features_harris);
            validation_features = transform_into_features(validation_set, @features_harris);
    end
end


function features = transform_into_features(dataset, features_fcn)
    set_transformed = transform(dataset, @(x) features_fcn(imadjust(x)));
    features = readall(set_transformed);
end