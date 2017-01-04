function [] = visualizationaudio(index,wholeResult,namepath,audiopath)

    [wa,wb,name]=xlsread(namepath,'A:A');
    name=name(index);
    name=cell2mat(name);
    
    writerObj = vision.VideoFileWriter('sample.avi','AudioInputPort',true);
    
    audioname=dir(audiopath);
    audioname=audioname(index+2);
    
    for i=2:size(wholeResult)
        
       if strcmp(name(i,:),name(i-1,:))==false
           hold off;
           
       end
        
       scatter(wholeResult(i,1),wholeResult(i,3),20,'r'); %prediction
       hold on;
       scatter(wholeResult(i,2),wholeResult(i,4),20,'b'); %truth
       hold on;
       x=[wholeResult(i,1),wholeResult(i,2)]; %arousal 
       y=[wholeResult(i,3),wholeResult(i,4)]; %valence
       plot(x,y,'g');
       axis([0 5 0 5]);
       xlabel('activation');
       ylabel('valence');
       text(0.5,0.5,name(i,:));
       set(gcf, 'Position', [100, 100, 1100,1100]);
       hold on;
       
       F=getframe;
       
       data=audioread([audiopath,'/',audioname(i).name]);
       step(writerObj,F,data);
       
    end
     
    release(writerObj);

end

