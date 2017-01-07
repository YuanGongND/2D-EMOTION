function [ timeStampMapping ] = FeatureExtraction( setting )
% use openSmile tools to extract emotion related features

dirRecording = dir( setting.recordingPath );
% the first two is not file, NOTICE, NOT SORTED BY NAME

% delete old feature file, avoid overlap
if ( exist( setting.featureFileName, 'file' ) )
    delete( setting.featureFileName );
end

% keep record of the mapping from feature of each segment to corresponding
% timeStamp
timeStampMapping = [];

for fileIndex = 3 : length( dirRecording )
    recordingFile = dirRecording( fileIndex ); 
    % call openSmile extract the feature 
    % be cautious of space in the command 
    system( ...
       ['SMILExtract_Release -C ',...
        setting.openSMILEPath,...
        '/',...
        'IS09_emotion.conf -I ',...
        setting.recordingPath,...
        '/',...
        recordingFile.name,...
        ' -O ',...
        setting.featureFileName ] );
    
    % determine which utterance/segment the wav belongs to
    recordingFileNameSplit = regexp( recordingFile.name, '_', 'split' );
    [ utteranceIndex, segmentIndex ] = deal( ...
        str2num( recordingFileNameSplit{ 1 } ),... 
        str2num( recordingFileNameSplit{ 2 } ) );...
        
    timeStampMapping = [ timeStampMapping; utteranceIndex, segmentIndex ];
    
end % end of processing all recording 

% save timeStampMapping
csvwrite( setting.timeStampMapping, timeStampMapping );

ConvertArffToCsv( setting );

% because file names may not be sorted in some system, the index of
% observation might not be consistant with segment and utterance
originalFeatrue = csvread( setting.featureFileName );
restoredIndexFeature = RestoreIndex( originalFeatrue, setting, timeStampMapping );
csvwrite( setting.featureFileName, restoredIndexFeature );

end % end of function
 
