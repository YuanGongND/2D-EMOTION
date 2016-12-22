clc;
clear;

%% CONSTANTS
valencepath ='..\..\data\IEMOCAP\feature\valenceSelection.csv';
arousepath='..\..\data\IEMOCAP\feature\arousalSelection.csv';
clabelpath='..\..\data\IEMOCAP\feature\claLabel.xlsx';
FEATUREVALENCEINDEX=[10,20,60,68,79,96,109,120,128,140,159,168,203,211,212,213,216,229,231,235,237,238,253,259,266,271,273,284,285,295,300,307,309,321,324,333,348,357]
FEATUREAROUSALINDEX=[2,4,7,9,11,19,21,27,31,37,39,44,48,50,67,84,91,99,103,105,128,133,134,148,156,163,165,167,194,195,196,213,216,219,225,231,237,240,249,261,264,276,285,307,309,324,326,343,349,363]

%% visualize in 2-D emotion space
resultacti=Train2DEmotionIEMOCAP(arousepath,FEATUREAROUSALINDEX,'-s 3 -t 0');
resultvale=Train2DEmotionIEMOCAP(valencepath,FEATUREVALENCEINDEX,'-s 3 -t 0');
[wa,wb,clabel]=xlsread(clabelpath,'A:A');
clabel=clabel(1:size(resultvale,1));

LABELLIST={'neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis'};

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

gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rkkgbcmkkyw','...........',30)
%gscatter(resultacti(:,1),resultvale(:,1))
xlabel('activity');
ylabel('valence');
legend('neu','xxx','fru','ang','sad','hap','exc','sur','oth','fea','dis')
saveas(gcf,'../../result/IEMOCAPtest','png');
%axis([-1 1 -1 1]);

%% statistial calculate the error
sqeracti=sum((resultacti(:,1)-resultacti(:,2)).^2)/size(resultacti,1);
sqervale=sum((resultvale(:,1)-resultvale(:,2)).^2)/size(resultvale,1);
sum=0;
for i=1:size(resultacti,1)
    temp=((resultacti(i,1)-resultacti(i,2))^2+(resultvale(i,1)-resultvale(i,2))^2)^(1/2);
    sum=sum+temp;
end
sqerdis=sum/size(resultacti,1);
