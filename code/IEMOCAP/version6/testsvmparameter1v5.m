function [sqeracti,sqervale,sqerdis,coefActi,coefVale] =testsvmparameter1v5(actipara,valepara,actiparac,valeparac,featurenum,trainIndex) % k-folders cross validation

%% CONSTANTS
arousepath='..\..\..\data\IEMOCAP\feature\pora.csv'; % actually a
valencepath ='..\..\..\data\IEMOCAP\feature\porl.csv'; % actually l
clabelpath='..\..\..\data\IEMOCAP\feature\clabelnonneutral.xlsx';
% FEATUREAROUSALINDEX=[15,20,24,25,72,80,108,109,120,133,140,152,201,212,213,216,225,228,229,235,248,249,285,296,297,300,307,309,313,319,320,321,324,333,336,343,345,357,369,372,384];
% FEATUREVALENCEINDEX=[3,9,32,104,117,178,194,195,196,248,256,297,344,363,370,371];

FEATUREAROUSALINDEX=[15,20,24,25,72,80,108,109,120,133,140,145,152,212,213,216,225,228,229,235,248,249,285,296,297,307,309,313,319,320,321,324,333,336,343,345,357,369,372,384];
FEATUREVALENCEINDEX=[2,4,7,9,10,11,43,56,96,99,104,105,117,127,156,171,194,195,196,203,256,265,276,280,298,299,303,324,337,360,363,373,380];
LABELLIST={'neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis'};
LIMIT=200;

%% prepare for the testing set (need to balance from )

testingIndex=[];

arouseData=xlsread(arousepath);
valenceData=xlsread(valencepath);
% arouseData=arouseData(trainIndex,:);
% valenceData=valenceData(trainIndex,:);

LENGTH=size(arouseData,1);

[wa,wb,clabel]=xlsread(clabelpath,'A:A');
% clabel=clabel(trainIndex,:);
clabel=clabel(1:LENGTH); % meaningless but just to solve the bug of xlsread

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
resultacti=Train2DEmotionIEMOCAPv3(arouseData,FEATUREAROUSALINDEX,actipara,trainingIndex,testingIndex,1);
resultvale=Train2DEmotionIEMOCAPv3(valenceData,FEATUREVALENCEINDEX,valepara,trainingIndex,testingIndex,1);

resultactiTree=Train2DEmotionIEMOCAPv3(arouseData,FEATUREAROUSALINDEX,actipara,trainingIndex,testingIndex,2);
resultvaleTree=Train2DEmotionIEMOCAPv3(valenceData,FEATUREVALENCEINDEX,valepara,trainingIndex,testingIndex,2);
% %% categorical test
% resultactiCate=Train2DEmotionIEMOCAPv2Cate(arouseData,FEATUREAROUSALINDEX(1:featurenum),actiparac,80,testingIndex,clabelEncode);
% resultvaleCate=Train2DEmotionIEMOCAPv2Cate(valenceData,FEATUREVALENCEINDEX(1:featurenum),valeparac,80,testingIndex,clabelEncode);


%% transform back to cart 

[predictx,predicty]=pol2cart(resultacti(:,1),resultvale(:,1));
[truex,truey]=pol2cart(resultacti(:,2),resultvale(:,2));
resultacti=[predictx,truex];
resultvale=[predicty,truey];

[predictx,predicty]=pol2cart(resultactiTree(:,1),resultvaleTree(:,1));
[truex,truey]=pol2cart(resultactiTree(:,2),resultvaleTree(:,2));
resultactiTree=[predictx,truex];
resultvaleTree=[predicty,truey];



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
%gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rmgbck','......',15);

% emotiongroup=zeros(size(resultacti,1),1);
% for i=1:size(resultacti,1)
%     for emotion=1:size(LABELLIST,2)
%         if char(clabel(i))==char(LABELLIST(emotion))
%             emotiongroup(i)=emotion;
%         end
%     end
% end

% gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rkkgbcmkkyw','...........',15);
% %gscatter(resultacti(:,1),resultvale(:,1))
% xlabel('activity');
% ylabel('valence');
% %legend('neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis')
% saveas(gcf,'../../result/IEMOCAPtest','png');
% 
%axis([-1 1 -1 1]);
scatter(resultactiTree(:,1),resultvaleTree(:,1),'filled');
hold on;
scatter(resultactiTree(:,2),resultvaleTree(:,2),'filled');
hold on;
for i=1:size(resultactiTree)
    x=[resultactiTree(i,1),resultactiTree(i,2)]; %prediction
    y=[resultvaleTree(i,1),resultvaleTree(i,2)]; %truth
    plot(x,y,'b');
    hold on
end
hold off
axis([-2.5 2.55 -2.5 2.5])
xlabel('activation')
ylabel('valence')
saveas(gcf,['../../../result/IEMOCAPtest2',actipara,valepara,num2str(featurenum),'folder',num2str(folder),'.png'],'png');

%% statistial calculate the error (svm)
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



