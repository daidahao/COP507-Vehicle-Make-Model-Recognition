% Extract Sobel Edge Response (SER) features from the image
%
% Usage:
%       f = features_ser(img)
% Arguements:
%       img     -   Image to be extracted features from.
% Returns:
%       f    	-   A ser feature vector.
function f = features_ser(img)
    [sx, sy] = imgradientxy(img, 'sobel');
    f = double([sx(:);sy(:)]);
    f = f';
end