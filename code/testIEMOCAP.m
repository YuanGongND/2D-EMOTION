filename='../data/IEMOCAP/Ses01F_impro01.wav'
evalname='../data/IEMOCAP/Ses01F_impro01.txt'
[x,Fs] = audioread(filename);
fileLength=size(x,1)/Fs

%% read evaluation file

fidin = fopen(evalname,'r');
nline = 0;

while ~feof(fidin)        
   tline = fgetl(fidin);
   if size(tline,2)>0
     if tline(1)=='['
       disp(tline)
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
       start=tline(mark3(1)+1:mark1-1)
       ed=tline(mark1+1:mark2(1)-1)
       name=tline(mark2(1)+2:mark3(2)-6)
       valence=tline(mark3(2)+1:mark4(1)-1)
       dominance=tline(mark4(1)+1:mark4(2)-1)
       arouse=tline(mark4(2)+1:mark2(2)-1)
       startTime=ceil(str2num(start)*Fs)
       edTime=ceil(str2num(ed)*Fs)
       name=strcat(name,'.wav')
       audiowrite(name,x(startTime:edTime),Fs)
     end
   end
   nline = nline+1;
end

fclose(fidin);