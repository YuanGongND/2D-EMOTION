function [sqeracti,sqervale,sqerdis,coefActi,coefVale] =testsvmparameter1v3(actipara,valepara,actiparac,valeparac,featurenum,trainIndex) %%leave-one-out

%% CONSTANTS
valencepath ='..\..\data\IEMOCAP\feature\valenceSelection.csv';
arousepath='..\..\data\IEMOCAP\feature\arousalSelection.csv';
clabelpath='..\..\data\IEMOCAP\feature\claLabel.xlsx';
FEATUREVALENCEINDEX=[10,20,60,68,79,96,109,120,128,140,159,168,203,211,212,213,216,229,231,235,237,238,253,259,266,271,273,284,285,295,300,307,309,321,324,333,348,357];
FEATUREAROUSALINDEX=[2,4,7,9,11,19,21,27,31,37,39,44,48,50,67,84,91,99,103,105,128,133,134,148,156,163,165,167,194,195,196,213,216,219,225,231,237,240,249,261,264,276,285,307,309,324,326,343,349,363];
LABELLIST={'neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis'};
LIMIT=200;
LENGTH=1819;
%% prepare for the testing set (need to balance from )

testingIndex=[];

arouseData=xlsread(arousepath);
valenceData=xlsread(valencepath);
arouseData=arouseData(trainIndex,:);
valenceData=valenceData(trainIndex,:);

[wa,wb,clabel]=xlsread(clabelpath,'A:A');
clabel=clabel(trainIndex,:);
%clabel=clabel(1:LENGTH); % meaningless but just to solve the bug of xlsread

%% cross-validation
cv = cvpartition(clabel,'KFold',size(trainIndex,1));

leaveoneoutresult=zeros(cv.NumTestSets,4); % 1=activation, 2=valence

for folder=1:cv.NumTestSets
    testingIndex=test(cv,folder);
    trainingIndex=training(cv,folder);

%% encode clabel into class number
clabelEncode=zeros(size(clabel,1),1);
for i=1:size(clabel,1)
    for j=1:size(LABELLIST,2)
        if char(clabel(i))==char(LABELLIST(j))
           clabelEncode(i)=j;   
        end
    end
end 

%% visualize in 2-D emotion space
resultacti=Train2DEmotionIEMOCAPv3(arouseData,FEATUREAROUSALINDEX(1:featurenum),actipara,trainingIndex,testingIndex,1); %mode 1: SVR mode 2
resultvale=Train2DEmotionIEMOCAPv3(valenceData,FEATUREVALENCEINDEX(1:featurenum),valepara,trainingIndex,testingIndex,1);

leaveoneoutresult(testingIndex,:)=[resultacti(:,1),resultacti(:,2),resultvale(:,1),resultvale(:,2)];

end  % end of cv
%% scatter plot. 

numberOfPointsShown=50;
numberOfPointsShown=randi([1,size(leaveoneoutresult,1)],numberOfPointsShown,1)

scatter(leaveoneoutresult(numberOfPointsShown,1),leaveoneoutresult(numberOfPointsShown,3),'filled','r'); %prediction
hold on;
scatter(leaveoneoutresult(numberOfPointsShown,2),leaveoneoutresult(numberOfPointsShown,4),'filled','b'); %ground truth
hold on;

for i=1:size(numberOfPointsShown)
    x=[leaveoneoutresult(numberOfPointsShown(i),1),leaveoneoutresult(numberOfPointsShown(i),2)]; %prediction
    y=[leaveoneoutresult(numberOfPointsShown(i),3),leaveoneoutresult(numberOfPointsShown(i),4)]; %truth
    plot(x,y,'k');
    hold on
end

axis([0 5 0 5]);
xlabel('activation');
ylabel('valence');
saveas(gcf,['../../result/IEMOCAPtest2',actipara,valepara,num2str(featurenum),'folder',num2str(folder),'.png'],'png');

%% statistial calculate the error
sqeracti=sum((leaveoneoutresult(:,1)-leaveoneoutresult(:,2)).^2)/size(leaveoneoutresult,1);
sqervale=sum((leaveoneoutresult(:,3)-leaveoneoutresult(:,4)).^2)/size(leaveoneoutresult,1);

tsum=0;
for i=1:size(leaveoneoutresult,1)
    temp=((leaveoneoutresult(i,1)-leaveoneoutresult(i,2))^2+(leaveoneoutresult(i,1)-leaveoneoutresult(i,2))^2)^(1/2);
    tsum=tsum+temp;
end

sqerdis=tsum/size(leaveoneoutresult,1);

ceffMatrixacti=corrcoef(leaveoneoutresult(:,1),leaveoneoutresult(:,2));
ceffMatrixvale=corrcoef(leaveoneoutresult(:,3),leaveoneoutresult(:,4));

coefActi=ceffMatrixacti(1,2);
coefVale=ceffMatrixvale(1,2);

hold off;
end 



