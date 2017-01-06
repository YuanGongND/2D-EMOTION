function [ cMse ] = CalculateMse( predictionAndTruth )

    %get prediction and truth from experiment result, column 1 is
    %prediction, column 2 is truth
    prediction = predictionAndTruth(:,1);
    truth = predictionAndTruth(:,2);
    cMse = sum( ( prediction-truth ).^2 ) / size(truth,1);

end

