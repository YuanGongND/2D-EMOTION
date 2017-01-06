function [sqeracti,sqervale,sqerdis,coefActi,coefVale,wholeResult] =testsvmparameter1v5(actipara,valepara,actiparac,valeparac,featurenum,trainIndex) % k-folders cross validation

%% CONSTANTS
valencepath ='..\..\..\data\IEMOCAP\feature\version1\valenceSelection.csv';
arousepath='..\..\..\data\IEMOCAP\feature\version1\arousalSelection.csv';
clabelpath='..\..\..\data\IEMOCAP\feature\version1\claLabel.xlsx';
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

wholeResult=zeros(size(clabel,1),6);
%% cross-validation
cv = cvpartition(clabel,'KFold',10)

tempsqeracti=zeros(cv.NumTestSets,1);
tempsqervale=zeros(cv.NumTestSets,1);
tempsqerdis=zeros(cv.NumTestSets,1);
tempcoefActi=zeros(cv.NumTestSets,1);
tempcoefVale=zeros(cv.NumTestSets,1);

tempsqeractiTree=zeros(cv.NumTestSets,1);
tempsqervaleTree=zeros(cv.NumTestSets,1);
tempsqerdisTree=zeros(cv.NumTestSets,1);
tempcoefActiTree=zeros(cv.NumTestSets,1);
tempcoefValeTree=zeros(cv.NumTestSets,1);


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
resultacti=Train2DEmotionIEMOCAPv3(arouseData,FEATUREAROUSALINDEX(1:featurenum),actipara,trainingIndex,testingIndex,1);
resultvale=Train2DEmotionIEMOCAPv3(valenceData,FEATUREVALENCEINDEX(1:featurenum),valepara,trainingIndex,testingIndex,1);

resultactiTree=Train2DEmotionIEMOCAPv3(arouseData,FEATUREAROUSALINDEX(1:featurenum),actipara,trainingIndex,testingIndex,2);
resultvaleTree=Train2DEmotionIEMOCAPv3(valenceData,FEATUREVALENCEINDEX(1:featurenum),valepara,trainingIndex,testingIndex,2);
% %% categorical test
% resultactiCate=Train2DEmotionIEMOCAPv2Cate(arouseData,FEATUREAROUSALINDEX(1:featurenum),actiparac,80,testingIndex,clabelEncode);
% resultvaleCate=Train2DEmotionIEMOCAPv2Cate(valenceData,FEATUREVALENCEINDEX(1:featurenum),valeparac,80,testingIndex,clabelEncode);

%% recover whole result 
% tj=1
% for ti=1:size(testingIndex)
%     if testingIndex(ti)==1
%     [wholeResult(ti,1),wholeResult(ti,2),wholeResult(ti,3),wholeResult(ti,4)]=deal(resultactiTree(tj,1),resultactiTree(tj,2),resultvaleTree(tj,1),resultvaleTree(tj,2));
%     end
%     j=j+1
% end

[wholeResult(testingIndex,1),wholeResult(testingIndex,2),wholeResult(testingIndex,3),wholeResult(testingIndex,4)]=deal(resultactiTree(:,1),resultactiTree(:,2),resultvaleTree(:,1),resultvaleTree(:,2));

%% scatter plot. 
% a = ones(size(resultacti,1),1)*30;
% color = zeros(size(resultacti,1),3);
% for i=1:size(resultacti,1)
%     for emotion=1:6
%         if resultacti(i,2)==activity(emotion) && resultvale(i,2)==valence(emotion)
%             emotiongroup(i)=emotion;
%         end
%     end
% end
% gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rmgbck','......',15);
% 
% emotiongroup=zeros(size(resultacti,1),1);
% for i=1:size(resultacti,1)
%     for emotion=1:size(LABELLIST,2)
%         if char(clabel(i))==char(LABELLIST(emotion))
%             emotiongroup(i)=emotion;
%         end
%     end
% end
% 
% gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rkkgbcmkkyw','...........',15);
% %gscatter(resultacti(:,1),resultvale(:,1))
% xlabel('activity');
% ylabel('valence');
% %legend('neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis')
% saveas(gcf,'../../result/IEMOCAPtest','png');

%axis([-1 1 -1 1]);
% scatter(resultactiTree(:,1),resultvaleTree(:,1),'filled');
% hold on;
% scatter(resultactiTree(:,2),resultvaleTree(:,2),'filled');
% hold on;
% for i=1:size(resultactiTree)
%     x=[resultactiTree(i,1),resultactiTree(i,2)]; %prediction
%     y=[resultvaleTree(i,1),resultvaleTree(i,2)]; %truth
%     plot(x,y,'b');
%     hold on
% end
% hold off
% axis([0 5 0 5])
% xlabel('activation')
% ylabel('valence')
% saveas(gcf,['../../../result/IEMOCAPtest2',actipara,valepara,num2str(featurenum),'folder',num2str(folder),'.png'],'png');

%% statistial calculate the error
tempsqeracti(folder)=sum((resultacti(:,1)-resultacti(:,2)).^2)/size(resultacti,1);
tempsqervale(folder)=sum((resultvale(:,1)-resultvale(:,2)).^2)/size(resultvale,1);
tsum=0;
for i=1:size(resultacti,1)
    temp=((resultacti(i,1)-resultacti(i,2))^2+(resultvale(i,1)-resultvale(i,2))^2)^(1/2);
    tsum=tsum+temp;
end

tempsqerdis(folder)=tsum/size(resultacti,1);

ceffMatrixacti=corrcoef(resultacti(:,1),resultacti(:,2));
ceffMatrixvale=corrcoef(resultvale(:,1),resultvale(:,2));

tempcoefActi(folder)=ceffMatrixacti(1,2);
tempcoefVale(folder)=ceffMatrixvale(1,2);

%% statistial calculate the error(tree)
tempsqeractiTree(folder)=sum((resultactiTree(:,1)-resultactiTree(:,2)).^2)/size(resultactiTree,1);
tempsqervaleTree(folder)=sum((resultvaleTree(:,1)-resultvaleTree(:,2)).^2)/size(resultvaleTree,1);
tsum=0;
for i=1:size(resultacti,1)
    temp=((resultacti(i,1)-resultacti(i,2))^2+(resultvale(i,1)-resultvale(i,2))^2)^(1/2);
    tsum=tsum+temp;
end

tempsqerdisTree(folder)=tsum/size(resultactiTree,1);

ceffMatrixactiTree=corrcoef(resultactiTree(:,1),resultactiTree(:,2));
ceffMatrixvaleTree=corrcoef(resultvaleTree(:,1),resultvaleTree(:,2));

tempcoefActiTree(folder)=ceffMatrixactiTree(1,2);
tempcoefValeTree(folder)=ceffMatrixvaleTree(1,2);

end
% sqeracti=mean(tempsqeracti);
% sqervale=mean(tempsqervale);
% sqerdis=mean(tempsqerdis);
% coefActi=mean(tempcoefActi);
% coefVale=mean(tempcoefVale);

sqeracti=[tempsqeracti,tempsqeractiTree];
sqervale=[tempsqervale,tempsqervaleTree];
sqerdis=[tempsqerdis,tempsqerdisTree];
coefActi=[tempcoefActi,tempcoefActiTree];
coefVale=[tempcoefVale,tempcoefValeTree];
end % end of cv



