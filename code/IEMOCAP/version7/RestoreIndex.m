function [ restoredResult, sortedIndex ] = RestoreIndex( originalResult, setting, timeStampMapping )
% restore the index to the sequence of segment/utterance

if nargin == 2
    timeStampMapping = csvread( setting.timeStampMapping );
end

toBeSort = [ timeStampMapping, originalResult ];
sortedResult = sortrows( toBeSort );
restoredResult = sortedResult( :, 3:size( originalResult, 2 ) );
sortedIndex = sortedResult( :, 1:2 );

end

