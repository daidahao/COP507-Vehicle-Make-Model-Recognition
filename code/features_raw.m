% Extract raw image features from the image
%
% Usage:
%       f = features_raw(img)
% Arguements:
%       img     -   Image to be extracted features from.
% Returns:
%       f    	-   A raw image feature vector.
function f = features_raw(img)
    f = double(img(:))';
end