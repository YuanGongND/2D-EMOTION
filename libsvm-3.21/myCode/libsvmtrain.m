function [model] =libsvmtrain(TrainingSet,LabelSet)
%wrap the libsvm to keep consistency with matlab svm

    LibTraining=TrainingSet;
    csvwrite('SPECTF.train',LibTraining);
    
    SPECTF = csvread('SPECTF.train'); % read a csv file
    %labels = SPECTF(:, 1); % labels from the 1st column
    labels=LabelSet;
    features = SPECTF(:, 2:end); 
    features_sparse = sparse(features); % features must be in a sparse matrix
    libsvmwrite('SPECTFlibsvm.train', labels, features_sparse);
    
    [heart_scale_label,heart_scale_inst]=libsvmread('SPECTFlibsvm.train');
    model=svmtrain(heart_scale_label,heart_scale_inst,'-s 3 -t 1'); %regression

end

