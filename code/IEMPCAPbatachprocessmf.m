[wa,name,wb]=xlsread('../result/IEMOCAPlabel/name.xlsx',1,'A:A'); %wa and wb are useless 
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
    
    csvwrite('../result/IEMOCAPlabel/indexMM.csv',indexMM);
    csvwrite('../result/IEMOCAPlabel/indexFM.csv',indexFM);
    csvwrite('../result/IEMOCAPlabel/indexMF.csv',indexMF);
    csvwrite('../result/IEMOCAPlabel/indexFF.csv',indexFF);
    
end
