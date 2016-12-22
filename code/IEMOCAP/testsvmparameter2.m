result=zeros(1,8);
for i=0:3
   for j=0:3
       for featurenum=5:5:30
       actipara=['-s 3 -t ',num2str(i)];
       valepara=['-s 3 -t ',num2str(j)];
       [sqeracti,sqervale,sqerdis,coefActi,coefVale]=testsvmparameter1(actipara,valepara,featurenum);
       result=[result;[i,j,featurenum,sqeracti,sqervale,sqerdis,coefActi,coefVale]];
       end
   end
end
       