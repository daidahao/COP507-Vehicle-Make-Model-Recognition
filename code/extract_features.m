function features = extract_features(dataset, profile)
    switch profile.features
        case 'raw'
            features = transform_into_features(dataset, @features_raw);
        case 'ser'
            features = transform_into_features(dataset, @features_ser);
        case 'smg'
            features = transform_into_features(dataset, @features_smg);
        case 'lnhs'
            depth = profile.features_options.depth;
            features = transform_into_features(dataset, ...
                @(img) features_harris(img, depth));
        case 'bsurf'
            bag = bagOfFeatures(dataset, ...
                'VocabularySize', profile.features_options.t);
            features = encode(bag, dataset);
    end
end


function features = transform_into_features(dataset, features_fcn)
    set_transformed = transform(dataset, @(x) features_fcn(imadjust(x)));
    features = readall(set_transformed);
end