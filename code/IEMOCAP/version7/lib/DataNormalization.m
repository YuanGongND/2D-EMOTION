function [ normalizedData, mean, std ] = DataNormalization(...
    originalData,... observation*384, openSmile output 384 features
    mean,... 1*384, the mean value of each of 384 features
    std... 1*384, the std of each of each of 384 features
    )
% normalize features to standard mean and std, using z-score.
% For training data, input: original data, do z-score and output: nomalizeddata, mean
% and std. For test data, input original data , mean, std of traing data. output
% normalizeddata

% when testing, need use the estimate parameters of trainging data
if nargin == 3 
    observationNum = size( originalData, 1 );
    meanRep = repmat( mean, [ observationNum, 1 ] );
    stdRep = repmat( std, [ observationNum, 1 ] );
    % z-score 
    normalizedData = ( originalData - meanRep ) ./ stdRep;
end

% when training
if nargin == 1
   [ normalizedData, mean, std ] = zscore( originalData );
end
    
end

