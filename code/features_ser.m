function f = features_ser(img)
    [sx, sy] = imgradientxy(img, 'sobel');
    f = double([sx(:);sy(:)]);
    f = f';
end