clc;
clear;

result=zeros(1,8);
index=csvread('../../result/IEMOCAPlabel/indexMM.csv');

m=5;
n=5;

activationresultsqer=zeros(m,n);
activationresultcoef=zeros(m,n);

valenceresultsqer=zeros(m,n);
valenceresultcoef=zeros(m,n);

featurenum=20;

c=0.01
e=0.01

for i=1:m
   for j=1:n
       
       actipara=['-s 3 -t 3 -c ',num2str(c),' -e ',num2str(e)];
       valepara=['-s 3 -t 3 -c ',num2str(c),' -e ',num2str(e)];
       [sqeracti,sqervale,sqerdis,coefacti,coefvale]=testsvmparameter1v4(actipara,valepara,'','',featurenum,index);
       
       activationresultsqer(i,j)=sqeracti;
       activationresultcoef(i,j)=coefacti;
       
       valenceresultsqer(i,j)=sqervale;
       valenceresultcoef(i,j)=coefvale;
      
       e=e*10
       
   end
   
   c=c*10
   e=0.01
end
       