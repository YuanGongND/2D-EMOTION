function [  ] = PlayVideo( setting )
% play audio and video together 

%% read video

vidObj = VideoReader( setting.sampleAnimation );
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
k = 1;
while hasFrame(vidObj)
    s(k).cdata = readFrame(vidObj);
    k = k+1;
end

set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
set(gca,'units','pixels');
set(gca,'position',[0 0 vidObj.Width vidObj.Height]);

%% read and play audio
[ recording, sampleRate ] = audioread( setting.recordingName );
sound( recording, sampleRate);

%% play video
movie(s,1,vidObj.FrameRate);
close;

end

