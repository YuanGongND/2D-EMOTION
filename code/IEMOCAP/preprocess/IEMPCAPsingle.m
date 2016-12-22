function [filename,clabelM,valenceMatrix,dominanceMatrix,arouseMatrix] = IEMPCAPsingle(filename,evalname,dest)
%UNTITLED Summary of this function goes here
%   For batch process a IEMOCAP impro, devide it into utterances and record
[x,Fs] = audioread(filename);
fileLength=size(x,1)/Fs;

%% Initialize matrix
valenceMatrix=[0];
dominanceMatrix=[0];
arouseMatrix=[0];
filename=[];
clabelM=[];

%% read evaluation file

fidin = fopen(evalname,'r');
nline = 0;

while ~feof(fidin)        
   tline = fgetl(fidin);
   if size(tline,2)>0
     if tline(1)=='['
       disp(tline);
       mark1=[];
       mark2=[];
       mark3=[];
       mark4=[];
       for i=1:size(tline,2)
         if tline(i)=='-'
             mark1=[mark1,i];
         end
         if tline(i)==']'
             mark2=[mark2,i];
         end
         if tline(i)=='['
             mark3=[mark3,i];
         end
         if tline(i)==','
             mark4=[mark4,i];
         end
       end
       start=tline(mark3(1)+1:mark1-1);
       ed=tline(mark1+1:mark2(1)-1);
       name=tline(mark2(1)+2:mark3(2)-6);
       clabel=tline(mark3(2)-4:mark3(2)-1);
       valence=tline(mark3(2)+1:mark4(1)-1);
       dominance=tline(mark4(1)+1:mark4(2)-1);
       arouse=tline(mark4(2)+1:mark2(2)-1);
       startTime=ceil(str2num(start)*Fs);
       edTime=ceil(str2num(ed)*Fs);
       %name=strcat(name,'.wav'); %%at here, detect how many sub-wav contains, and return the number, than here to duplicate lables*number
       %audiowrite([dest,name],x(startTime:edTime),Fs);  % write the audio
       numberOfClips=analyzeaudio(dest,name,x,startTime,edTime,1);
       
       valence=repmat(valence,numberOfClips,1);  % for the same segment, label should be same
       dominance=repmat(dominance,numberOfClips,1);
       arouse=repmat(arouse,numberOfClips,1);
       clabel=repmat(clabel,numberOfClips,1);
       name=repmat(name,numberOfClips,1);
       
       valenceMatrix=[valenceMatrix;str2num(valence)];
       dominanceMatrix=[dominanceMatrix;str2num(dominance)];
       arouseMatrix=[arouseMatrix;str2num(arouse)];
       filename=[filename;name];
       clabelM=[clabelM;clabel];
     end
   end
   nline = nline+1;
end

valenceMatrix(1)=[];
dominanceMatrix(1)=[];
arouseMatrix(1)=[];

fclose(fidin);

end

