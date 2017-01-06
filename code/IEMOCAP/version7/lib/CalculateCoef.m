function [ coef ] = CalculateCoef( predictionAndTruth )
% calculate coef between truth and prediction, assume the column 1 is
% prediction and column 2 is truth

prediction = predictionAndTruth( :, 1 );
truth = predictionAndTruth( :, 2 );

ceffMatrix = corrcoef( prediction, truth );
coef = ceffMatrix( 1, 2 );

end

