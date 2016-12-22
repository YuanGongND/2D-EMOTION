function [result] =Train2DEmotionIEMOCAPv2(TrainingSet,FeatureSet,Setting ,limit,testingIndex,mode)
     %% train the model on acti dimension
     LIMIT=200;
     
     tempdata=TrainingSet;
     trainingIndex=[];
     valimitMatrix=zeros(5,1);
     for i=1:size(tempdata,1)
        for j=1:5
            if tempdata(i,1)<j && tempdata(i,1)>=j-1
               valimitMatrix(j)=valimitMatrix(j)+1;
               if valimitMatrix(j)<=LIMIT
                   trainingIndex=[trainingIndex;i];
               end        
            end
        end 
     end
     
     allFeatureSet=tempdata(:,FeatureSet);
     %allFeatureSetNormal=mapminmax(allFeatureSet')';
     allFeatureSetNormal=zscore(allFeatureSet)
     LabelSet=tempdata(trainingIndex,1);
     TrainingSet=allFeatureSetNormal(trainingIndex,:);
     
     TestLabelSet=tempdata(testingIndex,1);
     TestingSet=allFeatureSetNormal(testingIndex,:);

    
     %% make prediction on acti/vale dimension
%      tLabelSet=tempdata(:,1);
%      tTestingSet= tempdata(:,FeatureSet);
%      tTestingSet= mapminmax(tTestingSet')';
%      [tresult,libaccuracy] = libsvmclassify(SVMStruct,[tLabelSet,tTestingSet]);
%      tresult=[tresult,tLabelSet];
     
     %% make prediction on acti/vale dimension (in selected (balanced) traing set)(svr)
    
     if mode==1

     SVMStruct = libsvmtrain(TrainingSet,LabelSet,Setting);
         
     [result,libaccuracy] = libsvmclassify(SVMStruct,[TestLabelSet,TestingSet]);
     result=[result,TestLabelSet];
     end
     %% make prediction on acti/vale dimension (in selected (balanced) traing set)(logistic regression)
     if mode==2
     
     tree = fitrtree(TrainingSet,LabelSet);
     Yfit=predict(tree,TestingSet);
     result=[Yfit,TestLabelSet];
     
     end
end
