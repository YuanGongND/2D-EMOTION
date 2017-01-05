function [  ] = EmotionAnimation( setting )
% animate the emotions

%% clean old figure
hold off;

%% initialize the video
v = VideoWriter( 'EmotionAnimation.mp4', 'MPEG-4');
% 1/frameRate should smaller than segment
v.FrameRate = 10;
open( v );

%% read recording
[ recording, sampleRate ] = audioread( setting.recordingName );
% merge two sound track
recording = recording( :, 1 ) + recording( :, 2 );
% convet x axis from points to second
xAxis = 1 : size( recording );
xAxis = xAxis / sampleRate; 

set(gcf,'unit','centimeters','position',[10 5 50 50]);
hrecording = subplot(2,1,1)
plot( xAxis, recording );
hold on;

%% read prediction result 
activationResult = csvread( setting.actiResult );
valenceResult = csvread( setting.valeResult );

%% read timeStamp
timeStampSeg = csvread( setting.timeStampSeg );
% start/end time of segment
timeStampStartInPoint = timeStampSeg( :, 1 );
timeStampEndInPoint = timeStampSeg( :, 2 );
% convert it into seconds 
timeStampStartInSec = timeStampSeg( :, 1 ) / sampleRate;
timeStampEndInSec = timeStampSeg( :, 2 ) / sampleRate;

%% make animation (triggered by timeline)
% initialize segment inex
segmentIndex = 1;
% initialize color map
emotionColorMap = hot;
% refresh every 1/FrameRate second 
for timeline = 0: 1/v.FrameRate: size( recording, 1 )/sampleRate
     if (timeline > timeStampStartInSec( segmentIndex )) && (timeline < timeStampEndInSec( segmentIndex ))
         % prepare recording segment corresponding time stamp
         recordingPart = recording( timeStampStartInPoint( segmentIndex ): timeStampEndInPoint( segmentIndex ) );
         % prepare x axis 
         xAxis = timeStampStartInPoint( segmentIndex ): timeStampEndInPoint( segmentIndex );
         % convert to seconds
         xAxis = xAxis / sampleRate;
         % the valence prediction of this section
         segmentValence = activationResult( segmentIndex, 1 );
         % use color to represent emotion (use smooting to avoid overflow)
         colorCode = emotionColorMap( 64 - ceil( segmentValence / 5 *63 ), : );
         % plot
         plot( xAxis, recordingPart, 'Color', colorCode );
         hold on
         % consider next segment if not to end
         if segmentIndex < size( timeStampSeg, 1 )
             segmentIndex = segmentIndex + 1;
         end  
     end
     % add frame to the video
     F = getframe( hrecording );
     line( [timeline timeline],[-1 -0.95],'Color', 'r');
     writeVideo( v, F );
     timeline
end

close(v);

PlayVideo( setting );
% release the video


end 
