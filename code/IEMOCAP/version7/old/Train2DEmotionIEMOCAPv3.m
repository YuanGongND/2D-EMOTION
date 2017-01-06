function [ model ] = TrainSvm ( TrainingSet,...
                                FeatureSet,...
                                Setting,...
                                trainingIndex,...
                                testingIndex...
                                mode)

%actiSvmModel = TrainSvm( activationData, ACTIVATIONFEATUREINDEX, actiParaReg, trainingIndex );
     tempdata=TrainingSet;
     
     allFeatureSet=tempdata(:,FeatureSet);
     %allFeatureSetNormal=mapminmax(allFeatureSet')';
     allFeatureSetNormal=zscore(allFeatureSet); %normalization
     
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
