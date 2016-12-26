% Initialize result matrix
resultMatrix = zeros(1,8);

% Train/Test on same speaker
sameSpeakerIndex = csvread('../../../data/IEMOCAP/feature/version1/indexMM.csv');

% Set range of SVM parameters
cRange = [0.001,0.01,0.1,1,10];
eRange = [0.001,0.01,0.1,1];

% Get result of all parameter sets
for c = cRange
   for e = eRange
       actipara=['-s 3 -t 2 -c ',num2str(c(i)),' -e ',num2str(e(j))];
       valepara=['-s 3 -t 2 -c ',num2str(c(i)),' -e ',num2str(e(j))];
       
       [sqeracti,sqervale,sqerdis,coefActi,coefVale,wholeResult]=testsvmparameter1v5(actipara,valepara,'','',featurenum,index);
       
%        result=[result;[i,j,featurenum,sqeracti,sqervale,sqerdis,coefActi,coefVale]];
%        
%        activationresultsqer(i,j)=sqeracti;
%        activationresultcoef(i,j)=coefActi;
%        
%        valenceresultsqer(i,j)=sqervale;
%        valenceresultcoef(i,j)=coefVale;
%        
%        i
%        j
       
       end
   end
end
       