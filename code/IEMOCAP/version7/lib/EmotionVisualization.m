function [ ] = EmotionVisualization( setting )
% static visualize the emotions

%% read recording
[ recording, sampleRate ] = audioread( setting.recordingName );
% merge two sound track
recording = recording( :, 1 ) + recording( :, 2 );
% convet x axis from points to second
xAxis = 1 : size( recording );
xAxis = xAxis / sampleRate; 

hrecording = subplot(2,1,1)
plot( xAxis, recording );
hold on;

%% read prediction result 
activationResult = csvread( setting.actiResult );
valenceResult = csvread( setting.valeResult );

%% read timeStamp
timeStampSeg = csvread( setting.timeStampSeg );

%% show the color coded result of each segment
for segmentIndex = 1 : size( timeStampSeg, 1 )
    segmentStart = timeStampSeg( segmentIndex, 1 ) / sampleRate;
    segmentLength = ( timeStampSeg( segmentIndex, 2 ) - timeStampSeg( segmentIndex, 1 ) ) / sampleRate;
    segmentValence = valenceResult( segmentIndex, 1 );
    % use color to represent emotion, currently only use valence, will
    % update in future 
    emotionColor = jet;
    colorCode = emotionColor( floor( segmentValence / 5 *64 ), : );
    rectangle('Position', [ segmentStart, 1.8, segmentLength, 0.2 ], 'FaceColor', colorCode );
    hold on;
end % end of show color-coded segment block

hold off;

end

