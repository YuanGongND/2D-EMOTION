function [] = outputaudio(index,audiopath)
% merge some audio in the file path, have some tricks
    
    audioname=dir(audiopath);
    indexfile=index+2;  % because first two of dir is nothing
    audioname=audioname(indexfile); % choose MM
    
    x=[];
    
    for i=2:size(index) % 1 is skipped by video
       
       [data,Fs]=audioread([audiopath,'/',audioname(i).name]);
       x=[x;data];
       
    end
    
    audiowrite('sample.wav',x,Fs);
    
end

