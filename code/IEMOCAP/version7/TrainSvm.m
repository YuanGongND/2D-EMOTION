function [ model ] = TrainSvm ( inputRawData,...  all samples and features
                                trainingIndex,...  only use part of raw data 
                                featureIndex,...   only use part of features
                                svmParameters...
                                )

%% Read raw data 
rawData = inputRawData;

%% seperate labels from raw data
labels = rawData( trainingIndex, 1);

%% seperate and preprocess features from raw data
rawfeatures = rawData( :, featureIndex );
% Normalize features using zscore
featuresNormalized = zscore( rawfeatures ); %normalization  %featuresNormalized=mapminmax(allFeatureSet')';
% only use selected samples
features = featuresNormalized( trainingIndex, : )

%% train svm model
model = libsvmtrain( features, labels, svmParameters );
         
end
