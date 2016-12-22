function [numberOfClips] = analyzeaudio(dest,name,x,startTime,edTime,mode) % x is the recording, index is the range of this rough cut.

if mode==1
    
Fs=16000;
numberOfClips=0;

while startTime+Fs<=edTime
    
    outputname=[name,'_',num2str(numberOfClips),'.wav'];
    audiowrite([dest,outputname],x(startTime:startTime+Fs),Fs);  % write the audio
    numberOfClips=numberOfClips+1;
    startTime=startTime+Fs+1;

end

%     outputname=[name,'_',num2str(numberOfClips),'.wav'];
%     audiowrite([dest,outputname],x(startTime:edTime),Fs); 

end 

end

