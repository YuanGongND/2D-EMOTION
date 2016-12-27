function [ result ] = TestSvm( inputRawData,...  all samples and features
                              model,... svm model
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
[ prediction, ~ ] = libsvmclassify( model, [ labels, features ] );
% the first column of return is prediction, the second column is truth
result=[ prediction, labels ];