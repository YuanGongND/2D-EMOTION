[wa,name,wb]=xlsread('../../../data/IEMOCAP/feature/version1/name.xlsx'); %wa and wb are useless 
indexMM=[];
indexFM=[];
indexMF=[];
indexFF=[];
for i=1:size(name,1)
    tempStr=name{i};
% 
%     if tempStr(6)=='M' && (tempStr(16)=='M' || tempStr(19)=='M')
%         indexMM=[indexMM;i];
%     end
%     
%     if tempStr(6)=='F' && (tempStr(16)=='M' || tempStr(19)=='M')
%         indexFM=[indexFM;i];
%     end
%     
%     if tempStr(6)=='M' && (tempStr(16)=='F' || tempStr(19)=='F')
%         indexMF=[indexMF;i];
%     end
%     
%     if tempStr(6)=='F' && (tempStr(16)=='F' || tempStr(19)=='F')
%         indexFF=[indexFF;i];
%     end
    
    if tempStr(6)=='M' && tempStr(16)=='M' 
        indexMM=[indexMM;i];
    end
    
    if tempStr(6)=='F' && tempStr(16)=='M'
        indexFM=[indexFM;i];
    end
    
    if tempStr(6)=='M' && tempStr(16)=='F'
        indexMF=[indexMF;i];
    end
    
    if tempStr(6)=='F' && tempStr(16)=='F' 
        indexFF=[indexFF;i];
    end
    
    csvwrite('../../../data/IEMOCAP/feature/version1/indexMM.csv',indexMM);
    csvwrite('../../../data/IEMOCAP/feature/version1/indexFM.csv',indexFM);
    csvwrite('../../../data/IEMOCAP/feature/version1/indexMF.csv',indexMF);
    csvwrite('../../../data/IEMOCAP/feature/version1/indexFF.csv',indexFF);
    
end
