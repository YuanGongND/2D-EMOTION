function [ timeStamp ] = VoiceActivityDetection( recording )
% Detect and make timestamp of the speech part of the recording

recording = recording ( :, 1 );
startTest = 1;
endTest = size( recording, 1 ); 

timeStamp = [];
while ( startTest < ( 0.9*size( recording, 1 ) ) )
    [ startTimeStamp, endTimeStamp ] = vad( recording( startTest : endTest ) );
    timeStamp = [ timeStamp; [ startTest + startTimeStamp, startTest + endTimeStamp ] ];
    startTest = startTest + endTimeStamp + 1
end

hold off;
plot( recording );
for i = 1: size( timeStamp, 1 )
    rectangle( 'Position', [ timeStamp( i, 1) 0 (timeStamp( i, 2)- timeStamp( i, 1)) 1 ] );
    hold on;
end
    