clc;
clear;

valencepath ='..\..\..\data\IEMOCAP\feature\valenceSelection.csv';
arousepath='..\..\..\data\IEMOCAP\feature\arousalSelection.csv';
clabelpath='..\..\..\data\IEMOCAP\feature\claLabel.xlsx';

apath ='..\..\..\data\IEMOCAP\feature\pora.csv';
lpath='..\..\..\data\IEMOCAP\feature\porl.csv';
clabeloutputpath='..\..\..\data\IEMOCAP\feature\clabelnonneutral.xlsx';

index=csvread('../../../result/IEMOCAPlabel/indexMM.csv');

arouseData=xlsread(arousepath);
valenceData=xlsread(valencepath);
[wa,wb,clabel]=xlsread(clabelpath,'A:A');

arouseData=arouseData(index,:);
valenceData=valenceData(index,:);
clabel=clabel(index,:);

arouseLabel=arouseData(:,1);
valenceLabel=valenceData(:,1);

arouseFeature=arouseData(:,2:size(arouseData,2));
valenceFeature=valenceData(:,2:size(valenceData,2));

[a,l]=cart2pol(arouseLabel-2.5,valenceLabel-2.5);

outputa=[a,arouseFeature];
outputl=[l,valenceFeature];

ind=find(l~=0); %% becaue original may confuse the system. So delete all original
% outputa=outputa(ind,:);
% outputl=outputl(ind,:);
% outputclabel=clabel(ind,:);
outputclabel=clabel(1:size(outputa,1),:);

csvwrite(apath,outputa);
csvwrite(lpath,outputl);
xlswrite(clabeloutputpath,cellstr(outputclabel));