function [accuracy, precision, recall, f1] = performance_scores(labels, pred)
    cm = confusionmat(labels, pred);
    accuracy = mean(labels == pred);
    precision = mean(diag(cm) ./ (sum(cm, 1)'), 'omitnan');
    recall = mean(diag(cm) ./ sum(cm, 2), 'omitnan');
    f1 = 2 * recall * precision / (precision + recall);
end