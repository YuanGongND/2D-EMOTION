function [ result ] = TestRt( inputRawData,...  all samples and features
                              model,... regression tree model
                              testIndex,...  only use part of raw data 
                              featureIndex...   only use part of features
                            )

                        %    actiRtResult = TestRt( activationData, actiRtModel, testingIndex, ACTIVATIONFEATUREINDEX );
%% Read raw data 
rawData = inputRawData;

%% seperate labels from raw data
labels = rawData( testIndex, 1);

%% seperate and preprocess features from raw data
rawfeatures = rawData( :, featureIndex );
% Normalize features using zscore
featuresNormalized = zscore( rawfeatures ); %normalization  %featuresNormalized=mapminmax(allFeatureSet')';
% only use selected samples
features = featuresNormalized( testIndex, : )

%% get result
prediction = predict( model, features );
% the first column of return is prediction, the second column is truth
result = [ prediction, labels ];