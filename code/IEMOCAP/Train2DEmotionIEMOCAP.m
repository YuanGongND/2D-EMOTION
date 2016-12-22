function [result] =Train2DEmotionIEMOCAP(TrainingSet,FeatureSet,Setting ,limit,testingIndex)
     %% train the model on acti dimension
     LIMIT=200;
     
     tempdata=xlsread(TrainingSet);
     trainingIndex=[];
     valimitMatrix=zeros(5,1);
     for i=1:size(tempdata,1)
        for j=1:5
            if tempdata(i,1)<=j && tempdata(i,1)>=j-1
               valimitMatrix(j)=valimitMatrix(j)+1;
               if valimitMatrix(j)<=LIMIT
                   trainingIndex=[trainingIndex;i];
               end        
            end
        end 
     end
     
     allFeatureSet=tempdata(:,FeatureSet);
     allFeatureSetNormal=mapminmax(allFeatureSet')';
     
     LabelSet=tempdata(trainingIndex,1);
     TrainingSet=allFeatureSetNormal(trainingIndex,:);
     SVMStruct = libsvmtrain(TrainingSet,LabelSet,Setting);
    
     %% make prediction on acti/vale dimension
     tLabelSet=tempdata(:,1);
     tTestingSet= tempdata(:,FeatureSet);
     tTestingSet= mapminmax(tTestingSet')';
     [tresult,libaccuracy] = libsvmclassify(SVMStruct,[tLabelSet,tTestingSet]);
     tresult=[tresult,tLabelSet];
     
     %% make prediction on acti/vale dimension (in selected (balanced) traing set)
     LabelSet=tempdata(testingIndex,1);
     TestingSet=allFeatureSetNormal(testingIndex,:);
     [result,libaccuracy] = libsvmclassify(SVMStruct,[LabelSet,TestingSet]);
     result=[result,LabelSet];
end

%      data=zeros(1,size(tempdata,2));
%      count1=0;count2=0;count3=0;count4=0;count5=0;
%      for i=1:size(tempdata,1)
%          if tempdata(i,1)<=1 && count1<=limit
%              count1=count1+1;
%              data=[data;tempdata(i,:)];
%              
%          elseif tempdata(i,1)<=2 && count2<=limit
%              count2=count2+1;
%              data=[data;tempdata(i,:)];
%          
%          elseif tempdata(i,1)<=3 && count3<=limit
%              count3=count3+1;
%              data=[data;tempdata(i,:)];
%          
%          elseif tempdata(i,1)<=4 && count4<=limit
%              count4=count4+1;
%              data=[data;tempdata(i,:)];
%         
%          elseif tempdata(i,1)<=5 && count5<=limit
%              count5=count5+1;
%              data=[data;tempdata(i,:)];
%          end     
%      end
%      data(1,:)=[];
%      
%      LabelSet=data(:,1);
%      TrainingSet=data(:,FeatureSet);
%      TrainingSetNormal=mapminmax(TrainingSet')';  % should have same normalization scale in training and testing set.
%      SVMStruct = libsvmtrain(TrainingSet,LabelSet,Setting);
%      