function [ timeStamp ] = VoiceActivityDetection( recording, sampleRate, setting )
% Detect and make timestamp of the speech part of the recording

% Merge two sound track
recording = recording ( :, 1 ) + recording ( :, 2 );
startTest = 1;
endTest = size( recording, 1 ); 

timeStamp = [];
while ( startTest < ( 0.9*size( recording, 1 ) ) )
    [ startTimeStamp, endTimeStamp ] = vad( recording( startTest : endTest ), setting );
    timeStamp = [ timeStamp; [ startTest + startTimeStamp, startTest + endTimeStamp ] ];
    startTest = startTest + endTimeStamp + 1;
end

%hold off;
plot( recording );
for i = 1: size( timeStamp, 1 )
    r = rectangle( 'Position', [ timeStamp( i, 1) setting.plothight (timeStamp( i, 2)- timeStamp( i, 1)) 0.01 ] );
    r.FaceColor = 'r';
    % save utterance wav recording
    %audiowrite( [ './tempfile/wav/' num2str( i ), '.wav' ], recording( timeStamp( i, 1 ) : timeStamp( i, 2 ) ), sampleRate ); 
    hold on;
end
    