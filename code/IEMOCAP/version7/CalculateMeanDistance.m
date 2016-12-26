function [ meanDistance ] = CalculateMeanDistance( actiPreTru, valePreTru )
% calculate mean distance between prediction and truth 

actiPrediction = actiPreTru( :, 1 );
actiTruth = actiPreTru( :, 2 );
valePrediction = valePreTru( :, 1 );
valeTruth = valePreTru( :, 2 );

sumDistance = 0;

% calculate the sum of distance
for i=1:size(actiTruth,1)
    tempDistance = ( ( actiPrediction(i)-actiTruth(i) )^2+( valePrediction(i)-valeTruth(i) )^2)^(1/2);
    sumDistance = sumDistance + tempDistance; 
end

meanDistance = sumDistance/size( actiTruth, 1 );

end

