function [ timeStampSegment ] = Segmentation ( timeStampUtterance, setting )
% cut utterance into smaller units, it is the actually unit to be processed

% time stamp is a 4 - tuple [ start, end, utterance, result]
timeStampSegment = [];
segmentLength = setting.segmentLength;

for i = 1 : size( timeStampUtterance )
    
    utteranceLength = timeStampUtterance( i , 2 ) - timeStampUtterance( i , 1 );
    segmentNum = floor( utteranceLength / segmentLength ); 
    
    % initialize start time 
    startSegment = timeStampUtterance( i ,1 );
    
    % process one utterance 
    for j = 1 : segmentNum
        timeStampSegment = [ timeStampSegment; startSegment, startSegment + segmentLength, i , 0];
        startSegment = startSegment + segmentLength + 1;
    end % end of process one utterance
    
    timeStampSegment = [ timeStampSegment; startSegment, timeStampUtterance( i , 2 ), i , 0];
    
end

end 
