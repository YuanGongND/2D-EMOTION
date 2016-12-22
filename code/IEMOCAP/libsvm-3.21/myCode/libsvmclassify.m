function [predict_label,accuracy,auc,rocx,rocy] =libsvmclassify(model,file)
%wrap the libsvm to keep consistency with matlab svm

    csvwrite('SPECTF.test',file);
    
    SPECTF = csvread('SPECTF.test'); % read a csv file
    labels = SPECTF(:, 1); % labels from the 1st column
    features = SPECTF(:, 2:end); 
    features_sparse = sparse(features); % features must be in a sparse matrix
    libsvmwrite('SPECTFlibsvm.test', labels, features_sparse);
    
    [heart_scale_label,heart_scale_inst]=libsvmread('SPECTFlibsvm.test');
    [predict_label,accuracy,probability_estimates] = svmpredict(heart_scale_label,heart_scale_inst,model,'b'); 
    
   % [auc,rocx,rocy]=plotroc(heart_scale_label,heart_scale_inst,model);

end