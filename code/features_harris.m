% Extract Locally Normalised Harris Strengths (LNHS) 
% features from the image
%
% Usage:
%       f = features_harris(img)
% Arguements:
%       img     -   Image to be extracted features from.
% Returns:
%       f       -   A lnhs feature vector.
function f = features_harris(img, depth)
    % Harris corner detector is provided by Peter Kovesi
    % source: https://www.peterkovesi.com/matlabfns/
    harris_response = harris(img, 1, 1e-6);
    % Recursive computation for LNHS
    f = divide_and_extract(harris_response, depth)';
end

function y = divide_and_extract(I, depth)
    depth = depth - 1;
    [r, c] = size(I);
    r_half = floor(r/2);
    c_half = floor(c/2);
    A = I(1:r_half,1:c_half);
    B = I(1:r_half,c_half+1:c);
    C = I(r_half+1:r,1:c_half);
    D = I(r_half+1:r,c_half+1:c);
    if depth == 0
        y = [];
    else
        y = [divide_and_extract(A, depth);divide_and_extract(B, depth);...
            divide_and_extract(C, depth);divide_and_extract(D, depth)];
    end
    summ = sum(I, 'all');
    if summ == 0
        y(end+1:end+4, 1) = 0;
    else
        y(end+1, 1) = sum(A, 'all') / summ;
        y(end+1, 1) = sum(B, 'all') / summ;
        y(end+1, 1) = sum(C, 'all') / summ;
        y(end+1, 1) = sum(D, 'all') / summ;
    end
end

