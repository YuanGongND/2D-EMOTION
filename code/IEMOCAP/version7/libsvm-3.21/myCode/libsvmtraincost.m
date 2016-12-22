function [model] =libsvmtraincost(Weight,TrainingSet,LabelSet,cost)
 %wrap the libsvm to keep consistency with matlab svm

    if nargin<=3
        cost=1;
    end

    
    LibTraining=TrainingSet;
    csvwrite('SPECTF.train',LibTraining);
    
    SPECTF = csvread('SPECTF.train'); % read a csv file
    labels=LabelSet;
    %labels = SPECTF(:, 1); % labels from the 1st column
    features = SPECTF(:, 2:end); 
    features_sparse = sparse(features); % features must be in a sparse matrix
    libsvmwrite('SPECTFlibsvm.train', labels, features_sparse);
    
    [heart_scale_label,heart_scale_inst]=libsvmread('SPECTFlibsvm.train');
    
    costop=num2str(cost);
    costoption=['-t 0 -c ',costop];
    
    model=svmtrain(Weight,heart_scale_label,heart_scale_inst, costoption);

end

