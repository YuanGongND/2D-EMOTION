result=zeros(1,8);
index=csvread('../../result/IEMOCAPlabel/indexMM.csv');
for i=0
   for j=0
       for featurenum=20
       actipara=['-s 3 -t ',num2str(i),' -c 0.1 -e 0.1 -d 1'];
       valepara=['-s 3 -t ',num2str(j),'-c 0.1 -e 0.1 -d 1'];
       [sqeracti,sqervale,sqerdis,coefActi,coefVale]=testsvmparameter1v2(actipara,valepara,'','',featurenum,index);
       result=[result;[i,j,featurenum,sqeracti,sqervale,sqerdis,coefActi,coefVale]];
       end
   end
end
       