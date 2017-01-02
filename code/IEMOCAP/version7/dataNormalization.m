function [ normalizedData, mean, std ] = dataNormalization( originalData, mean, std )
% for training data, input: original data, do z-score and output: nomalizeddata, mean
% and std 
% for test data, input original data , mean, std of traing data. output
% normalizeddata

% when testing, need the estimate parameters of trainging data
if nargin == 3 

end

