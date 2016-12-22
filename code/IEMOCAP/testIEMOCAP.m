clear;
clc;

%% constant
%FILE_PATH='.\data\wholeFeatureSet.csv';
%FEATUREINDEX=[3,4,5,10,11,12,14,18,21,23,24,25,26,33,38,46,47,52,67,73,75,80,114,160,165,175,189];
FEATUREINDEX=3:189

FEATUREVALENCEINDEX=[10,20,60,68,79,96,109,120,128,140,159,168,203,211,212,213,216,229,231,235,237,238,253,259,266,271,273,284,285,295,300,307,309,321,324,333,348,357]
FEATUREAROUSALINDEX=[2,4,7,9,11,19,21,27,31,37,39,44,48,50,67,84,91,99,103,105,128,133,134,148,156,163,165,167,194,195,196,213,216,219,225,231,237,240,249,261,264,276,285,307,309,324,326,343,349,363]
LABELLIST={'neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis'};
%% read csv file and select features

valencedata = xlsread('..\..\data\IEMOCAP\feature\valenceSelection.csv');
arousedata=xlsread('..\..\data\IEMOCAP\feature\arousalSelection.csv');


featureIndex=FEATUREINDEX; %the features are selected from weka
featureIndex=featureIndex+1;
featureIndex=[1,2,featureIndex];
selectfeature= data(:,featureIndex);
speaker=[1,2,3,4];
emotion=[1,2,3,4,5,6];
emotionLabel=['angry','fear','happy','neutral','sad','suprise'];
speaker=['liu','wang','zhaoq','zhaoz'];
load('v.mat');  % estimate position in 2-D emotion space
load('a.mat');

%% change emotion into activation/valence space

selectFeatureActi=selectfeature;
selectFeatureVale=selectfeature;

 for emotion=1:6
         selectFeatureActi(find(selectfeature(:,2)==emotion),2)=activity(emotion);
         selectFeatureVale(find(selectfeature(:,2)==emotion),2)=valence(emotion);
 end
 
 %% sperate different speakers
 
 for speaker=1:4
        tempFile=selectFeatureActi(find(selectFeatureActi(:,1)==speaker),:);
        csvwrite(strcat('..\data\speaker',num2str(speaker),'_acti.csv'),tempFile)
        tempFile=selectFeatureVale(find(selectFeatureVale(:,1)==speaker),:);
        csvwrite(strcat('..\data\speaker',num2str(speaker),'_vale.csv'),tempFile)
end
%for speaker=1:4 
  %  tempfile=selectfeature[]
    