result=zeros(1,8);0.0
index=csvread('../../../data/IEMOCAP/feature/version1/indexMM.csv');

c=[0.001,0.01,0.1,1,10];
e=[0.001,0.01,0.1,1];

m=size(c,2);
n=size(e,2);

activationresultsqer=zeros(m,n);
activationresultcoef=zeros(m,n);

valenceresultsqer=zeros(m,n);
valenceresultcoef=zeros(m,n);

for i=2
   for j=2
       
       for featurenum=20
           
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
       