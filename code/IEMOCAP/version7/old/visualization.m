function [] = visualization(index,wholeResult,namepath,clabelpath)

    [wa,wb,name]=xlsread(namepath,'A:A');
    [wa,wb,clabel]=xlsread(clabelpath,'A:A');
    name=name(index);
    clabel=clabel(index);
    name=cell2mat(name);
    clabel=cell2mat(clabel);
    v = VideoWriter('newfile1.avi','Motion JPEG AVI');
    v.FrameRate=1;
    open(v);
    
    for i=2:size(wholeResult)
        
       if strcmp(name(i,:),name(i-1,:))==false
           hold off;
           
       end
        
       scatter(wholeResult(i,3),wholeResult(i,1),20,'r','filled'); %prediction
       hold on;
       scatter(wholeResult(i,4),wholeResult(i,2),20,'b','filled'); %truth
       hold on;
       
       x=[wholeResult(i,3),wholeResult(i,4)]; %valence
       y=[wholeResult(i,1),wholeResult(i,2)]; %arousal 
       
       plot(x,y,'g','LineWidth',2);
       axis([0 5 0 5]);
       xlabel('valence');
       ylabel('activation');
       text(0.5,0.5,name(i,:));
       text(0.5,1,clabel(i,:),'Color','red','FontSize',14);
       set(gcf, 'Position', [100, 100, 1100,1100]);
       hold on;
       
       F=getframe(gcf);
       writeVideo(v,F); 
       
    end
    
    close(v);

end

