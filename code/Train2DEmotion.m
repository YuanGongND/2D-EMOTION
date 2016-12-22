function [result] =Train2DEmotion(TrainingSet,FeatureSet)
     %% train the model on acti dimension
     data=xlsread(TrainingSet);
     LabelSet=data(:,2);
     TrainingSet=data(:,FeatureSet);
     TrainingSet=mapminmax(TrainingSet')';
     SVMStruct = libsvmtrain(TrainingSet,LabelSet);
     
     %% make prediction on acti dimension
     [result,libaccuracy] = libsvmclassify(SVMStruct,[LabelSet,TrainingSet]);
     result=[result,LabelSet];
end

