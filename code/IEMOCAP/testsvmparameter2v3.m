result=zeros(1,8);
index=csvread('../../result/IEMOCAPlabel/indexMM.csv');
for i=2
   for j=2
       for featurenum=20
       actipara=['-s 3 -t ',num2str(i),' -c 10 -e 0.2'];
       valepara=['-s 3 -t ',num2str(j),'-c 10 -e 0.2'];
       [sqeracti,sqervale,sqerdis,coefActi,coefVale]=testsvmparameter1v3(actipara,valepara,'','',featurenum,index);
       result=[result;[i,j,featurenum,sqeracti,sqervale,sqerdis,coefActi,coefVale]];
       end
   end
end
       