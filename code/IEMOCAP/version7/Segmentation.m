function [ timeStampSegment ] = Segmentation ( recording, sampleRate, timeStampUtterance, setting )
% cut utterance into smaller units, it is the actually unit to be processed

% delete temp wav file
delete( [ setting.recordingPath, '/*.wav' ] );

% time stamp is a 4 - tuple [ start, end, utterance, result]
timeStampSegment = [];
segmentLength = setting.segmentLength;
% merge two track
recording = recording ( :, 1 ) + recording ( :, 2 );

% process utterances in one recording
for i = 1 : size( timeStampUtterance ) 
    
    utteranceLength = timeStampUtterance( i, 2 ) - timeStampUtterance( i, 1 );
    segmentNum = floor( utteranceLength / segmentLength ); 
    
    % initialize start time 
    startSegment = timeStampUtterance( i, 1 );
    
    % process one utterance 
    for j = 1 : segmentNum
        timeStampSegment = [ timeStampSegment; startSegment, startSegment + segmentLength, i , 0];
        
        audiowrite( [ './tempfile/wav/' num2str( i ), '_', num2str( j ) '_.wav' ], ... temp wav path
                      recording( startSegment : ( startSegment + segmentLength ) ), ... wav segment
                      sampleRate ); ... segment
                  
        startSegment = startSegment + segmentLength + 1;
    end % end of process one utterance
    
    % the last (not complete) segment, keep if it has enough length
    if( timeStampUtterance( i , 2 ) - startSegment > segmentLength*0.5 ) 
    timeStampSegment = [ timeStampSegment; startSegment, timeStampUtterance( i , 2 ), i , 0];
    
    audiowrite( [ './tempfile/wav/' num2str( i ), '_', num2str( j+1 ) '_.wav' ], ... temp wav path
              recording( startSegment : timeStampUtterance( i , 2 ) ), ... wav segment
              sampleRate ); ... segment
    end % end of process last segment of utterance
    
end % end of process all utterances

end 
