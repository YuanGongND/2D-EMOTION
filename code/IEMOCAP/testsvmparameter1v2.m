function [sqeracti,sqervale,sqerdis,coefActi,coefVale] =testsvmparameter1v2(actipara,valepara,actiparac,valeparac,featurenum,trainIndex)

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
limitMatrix=zeros(size(LABELLIST,2),1);
for i=1:size(clabel,1)
    for j=1:size(LABELLIST,2)
        if char(clabel(i))==char(LABELLIST(j))
            limitMatrix(j)=limitMatrix(j)+1;
            if limitMatrix(j)<=LIMIT
               testingIndex=[testingIndex;i];
            end        
        end
    end
end 

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
resultacti=Train2DEmotionIEMOCAPv2(arouseData,FEATUREAROUSALINDEX(1:featurenum),actipara,80,testingIndex,2);
resultvale=Train2DEmotionIEMOCAPv2(valenceData,FEATUREVALENCEINDEX(1:featurenum),valepara,80,testingIndex,2);

%% categorical test
resultactiCate=Train2DEmotionIEMOCAPv2Cate(arouseData,FEATUREAROUSALINDEX(1:featurenum),actiparac,80,testingIndex,clabelEncode);
resultvaleCate=Train2DEmotionIEMOCAPv2Cate(valenceData,FEATUREVALENCEINDEX(1:featurenum),valeparac,80,testingIndex,clabelEncode);

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

emotiongroup=zeros(size(resultacti,1),1);
for i=1:size(resultacti,1)
    for emotion=1:size(LABELLIST,2)
        if char(clabel(i))==char(LABELLIST(emotion))
            emotiongroup(i)=emotion;
        end
    end
end

gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rwkgbcmwwyw','...........',25);
%gscatter(resultacti(:,1),resultvale(:,1))
xlabel('activation','FontSize',20);
ylabel('valence','FontSize',20);
legend('neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis')
saveas(gcf,'../../result/IEMOCAPtest','png');

%axis([-1 1 -1 1]);
gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rrrrrrrrrrr','...........',15);
hold on;
gscatter(resultacti(:,2),resultvale(:,2),emotiongroup,'bbbbbbbbbbb','...........',15);
hold on;
for i=1:size(resultacti)
    x=[resultacti(i,1),resultacti(i,2)]; %prediction
    y=[resultvale(i,1),resultvale(i,2)]; %truth
    plot(x,y,'b');
    hold on
end
hold off
axis([0 5 0 5])
xlabel('arousal')
ylabel('valence')
saveas(gcf,['../../result/IEMOCAPtest2',actipara,valepara,num2str(featurenum)],'png');

%% statistial calculate the error
sqeracti=sum((resultacti(:,1)-resultacti(:,2)).^2)/size(resultacti,1);
sqervale=sum((resultvale(:,1)-resultvale(:,2)).^2)/size(resultvale,1);
tsum=0;
for i=1:size(resultacti,1)
    temp=((resultacti(i,1)-resultacti(i,2))^2+(resultvale(i,1)-resultvale(i,2))^2)^(1/2);
    tsum=tsum+temp;
end
sqerdis=tsum/size(resultacti,1);

ceffMatrixacti=corrcoef(resultacti(:,1),resultacti(:,2));
ceffMatrixvale=corrcoef(resultvale(:,1),resultvale(:,2));
coefActi=ceffMatrixacti(1,2);
coefVale=ceffMatrixvale(1,2);

end