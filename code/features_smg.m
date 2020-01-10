% Extract Square Mapped Gradients (SMG) features from the image
%
% Usage:
%       f = features_smg(img)
% Arguements:
%       img     -   Image to be extracted features from.
% Returns:
%       f    	-   A smg feature vector.
function f = features_smg(img)
    [sx, sy] = imgradientxy(img, 'sobel');
    gx = (sx.^2 - sy.^2) ./ (sx.^2 + sy.^2);
    gy = (2 .* sx .* sy) ./ (sx.^2 + sy.^2);
    gx((sx==0) & (sy==0)) = 0;
    gy((sx==0) & (sy==0)) = 0;
    f = [gx(:);gy(:)]';
end