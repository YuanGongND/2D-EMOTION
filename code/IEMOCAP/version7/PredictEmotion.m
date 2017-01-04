function [ resultActi, resultVale ] = PredictEmotion( setting )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% load model(acti/vale model,svm/rt model, normalization factor)
load( 'model.mat' );
% load data (whole feature set)
originalFeature = xlsread( setting.featureFileName );
% developping, will be true label in next version
fakeLabel = ones( size( originalFeature, 1 ), 1 );
% true label is blind in the test, only used to calculate accuracy
testdata = [ fakeLabel, originalFeature ];
% testing all 
testIndex = 1:size( originalFeature, 1 );

% predict activation
resultActi = TestRt( testdata,... observations*features, first column is label, 2-end are features
                     actiRtModel,...
                     testIndex,...
                     setting.activationFeatureIndex,...
                     normalizationFactor...
                     );
                 
% predict valence
resultVale = TestRt( testdata,... observations*features, first column is label, 2-end are features
                     valeRtModel,...
                     testIndex,...
                     setting.valenceFeatureIndex,...
                     normalizationFactor...
                     );
                 
% restore index, the data is not organized with sequence of
% utterance/segment, restore this sequence

resultActiRes = RestoreIndex( timeStamp, resultActi );
resultValeRes = RestoreIndex( timeStamp, resultVale ); 

csvwrite( setting.actiResultPath, resultActiRes );
csvwrite( setting.valeResultPath, resultValeRes );

end

