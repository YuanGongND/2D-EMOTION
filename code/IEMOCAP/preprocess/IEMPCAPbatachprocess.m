wavdir = '../../../data/IEMOCAP/origin/wav';
wavfile=dir(wavdir);
wavfiledir = '../../../data/IEMOCAP/origin/wav/';
evaldir = '../../../data/IEMOCAP/origin/eval/';
destdir='../../../result/IEMOCAPwav/version1/'

resultLabel=[0,0,0];
name=[];
clabelM=[];
for i=3:length(wavfile)
   wavname=wavfile(i).name;
   evalname=[wavname(1:size(wavname,2)-4),'.txt'];
   [filename,clabel,valence,dominance,arouse] = IEMPCAPsingle([wavfiledir,wavname],[evaldir,evalname],destdir);  %single process code here
   %resultLabel=[resultLabel;str2num(valence),str2num(dominance),str2num(arouse)];
   resultLabel=[resultLabel;valence,dominance,arouse];
   name=char(name,filename);
   clabelM=char(clabelM,clabel);
end

resultLabel(1,:)=[];
xlswrite('../../../data/IEMOCAP/feature/version1/numLabel.xlsx',resultLabel);

clabelM(1,:)=[];
xlswrite('../../../data/IEMOCAP/feature/version1/claLabel.xlsx',cellstr(clabelM));

name(1,:)=[];
xlswrite('../../../data/IEMOCAP/feature/version1/name.xlsx',cellstr(name));

