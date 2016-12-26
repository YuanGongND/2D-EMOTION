function [...
    actiMse, ... mean squear error of activation, column 1 is result of svm, column 2 is the result of rt 
    valeMse, ... 
    disMean, ... mean distance between truth and prediction in 2D space 
    actiCoef, ...correlation coefficient between truth and prediciton of activation
    valeCoef, ...
    wholeResult] = TestSVM(actiParaReg, ... SVM parameters when training activation regression
                           valeParaReg, ... 
                           actiParaCate, ... SVM parameters when training activation categorical classes
                           valeParaCate, ...
                           featureNum, ... number of features used
                           speakerIndex) % index of training set to keep same speaker 
                       
%% CONSTANTS

% path of data
VALENCEPATH = '..\..\..\data\IEMOCAP\feature\version1\valenceSelection.csv';
AROUSEPATH = '..\..\..\data\IEMOCAP\feature\version1\arousalSelection.csv';
CATELABELPATH = '..\..\..\data\IEMOCAP\feature\version1\claLabel.xlsx';

% selected features
VALENCEFEATUREINDEX = [10,20,60,68,79,96,109,120,128,140,159,168,203,211,212,213,216,229,231,235,237,238,253,259,266,271,273,284,285,295,300,307,309,321,324,333,348,357];
ACTIVATIONFEATUREINDEX = [2,4,7,9,11,19,21,27,31,37,39,44,48,50,67,84,91,99,103,105,128,133,134,148,156,163,165,167,194,195,196,213,216,219,225,231,237,240,249,261,264,276,285,307,309,324,326,343,349,363];
LABELLIST={'neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis'};

%
NUMBEROFFOLDS=10;

%% Prepare data 

activationData = xlsread( arousepath );
valenceData = xlsread( valencepath );

% keep experiment on samespeaker
arouseData = arouseData( speakerIndex, : );
valenceData = valenceData( speakerIndex, : );

% matlab way to read text from excel
[~,~,clabel] = xlsread( clabelpath, 'A:A' );

% must name the index, bug of xlsread text
clabel = clabel( speakerIndex, : );  

% initialize result matrix 
wholeResult = zeros( size ( clabel, 1 ), 6 );

%% Cross-validation training and testing 

% Stratified by catelogical labels
cv = cvpartition( clabel, 'KFold', NUMBEROFFOLDS );

% Initialize matrix records the result
[actiMseSvmFolder... % result of each folder of SVR 
 valeMseSvmFolder...
 disMeanSvmFolder...
 actiCoefSvmFolder...
 valeCoefSvmFolder...
 ] = deal( zeros( cv.NumTestSets,1 ) );

[actiMseRtFolder... % result of each folder of Regression Tree
 valeMseRtFolder...
 disMeanRtFolder...
 actiCoefRtFolder...
 valeCoefRtFolder...
 ] = deal( zeros( cv.NumTestSets,1 ) );

% Assign training and test index
for folder = 1:cv.NumTestSets
    trainingIndex = training( cv,folder );
    testingIndex = test( cv,folder );

    % Train models
    actiSvmModel = TrainSvm( activationData, ACTIVATIONFEATUREINDEX, actiParaReg, trainingIndex );
    valeSvmModel = TrainSvm( valenceData, VALENCEFEATUREINDEX, valeParaReg, trainingIndex );
    actiRtModel = TrainRt ( activationData, ACTIVATIONFEATUREINDEX, trainingIndex ); % current regression tree does not have para
    valeRtModel = TrainRt ( valenceData, VALENCEFEATUREINDEX, trainingIndex );
    
    % Testing
    actiSvmResult = TestSvm( activationData, actiSvmModel, testingIndex );
    valeSvmResult = TestSvm( valenceData, valeSvmModel, testingIndex );
    actiRtResult = TestRt( activationData, actiRtModel, testingIndex );
    valeRtResult = TestRt( valenceData, valeRtModel, testingIndex );
    
    % fill in raw result by original index
    [wholeResult(testingIndex,1),... % activation svm prediction
        wholeResult(testingIndex,2),... % valence svm prediction
        wholeResult(testingIndex,3),... % activation regression tree prediction
        wholeResult(testingIndex,4)... % valence regression tree prediction
        wholeResult(testingIndex,5)... % activation truth
        wholeResult(testingIndex,6)... % valence truth
        ]=deal( actiSvmResult(:,1), valeSvmResult(:,1), actiRtResult(:,1), valeRtResult(:,1), actiSvmResult(:,2), valeSvmResult(:,2) );

    % fill in statistical result by folder (SVM)
    [actiMseSvmFolder(folder),...
     valeMseSvmFolder(folder),...
     disMeanSvmFolder(folder),...
     actiCoefSvmFolder(folder),...
     valeCoefSvmFolder(folder)] = deal( CalculateMse( actiSvmResult ),...
                                        CalculateMse( valeSvmResult ),...
                                        CalculateMeanDistance( actiSvmResult, valeSvmResult ),...
                                        CalculateCoef( actiSvmResult ),...
                                        CalculateCoef( valeSvmResult ) );
                                    
    % fill in statistical result by folder (Regression Tree)
    [actiMseRtFolder(folder),...
     valeMseRtFolder(folder),...
     disMeanRtFolder(folder),...
     actiCoefRtFolder(folder),...
     valeCoefRtFolder(folder)] = deal( CalculateMse( actiRtResult ),...
                                       CalculateMse( valeRtResult ),...
                                       CalculateMeanDistance( actiRtResult, valeRtResult ),...
                                       CalculateCoef( actiRtResult ),...
                                       CalculateCoef( valeRtResult ) );

end % end of cross validation

%% output, column 1 is result of SVM, column is result of regression tree
actiMse = [ actiMseSvmFolder, actiMseRtFolder ]; 
valeMse = [ valeMseSvmFolder, valeMseRtFolder ];
disMean = [ disMeanSvmFolder, disMeanRtFolder ];
actiCoef = [ actiCoefSvmFolder, actiCoefRtFolder ];
valeCoef = [ valeCoefSvmFolder, valeCoefRtFolder ];

end % end of fucntion



