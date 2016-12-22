clear;
clc;

%% constant
%FILE_PATH='.\data\wholeFeatureSet.csv';
%FEATUREINDEX=[3,4,5,10,11,12,14,18,21,23,24,25,26,33,38,46,47,52,67,73,75,80,114,160,165,175,189];
FEATUREINDEX=3:189

%% read csv file and select features

data = xlsread('..\data\wholeFeatureSet.csv');
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
    