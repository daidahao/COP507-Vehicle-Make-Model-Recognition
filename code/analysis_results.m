figure;
miss = find(pred~=dataset.Labels);
for i = 1:sum(pred~=dataset.Labels)
    subplot(1, 2, i);
    imshow(readimage(dataset, miss(i)));
    title(sprintf("True Label = %s\nPredicted Label = %s", ...
        strrep(string(dataset.Labels(miss(i))), '_', '\_'), ...
        strrep(string(pred(miss(i))), '_', '\_')...
    ));
end
    