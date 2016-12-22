clc;
clear;


%% visualize in 2-D emotion space
resultacti=Train2DEmotion('..\data\speaker2_acti.csv',[3,5,10,11,12,20,21,24,25,66,73,75,79,91,93,102,168,185,186,189]);
resultvale=Train2DEmotion('..\data\speaker2_vale.csv',[3,5,20,21,25,40,59,66,67,68,74,80,84,86,91,96,98,105,106,175,182,185,186,187,188,189]);
load('a.mat');
load('v.mat');

emotionLabel=['angry','fear','happy','neutral','sad','suprise'];

%% scatter plot. 
a = ones(size(resultacti,1),1)*30;
color = zeros(size(resultacti,1),3);
for i=1:size(resultacti,1)
    for emotion=1:6
        if resultacti(i,2)==activity(emotion) && resultvale(i,2)==valence(emotion)
            emotiongroup(i)=emotion;
        end
    end
end
gscatter(resultacti(:,1),resultvale(:,1),emotiongroup,'rmgbck','......',15);
xlabel('activity');
ylabel('valence');
legend('angry','fear','happy','neutral','sad','suprise')
saveas(gcf,'../result/speaker2','png');
%axis([-1 1 -1 1]);
