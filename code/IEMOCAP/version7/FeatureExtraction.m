function [ output_args ] = FeatureExtraction( setting )
% use openSmile tools to extract emotion related features

dirRecording = dir( setting.recordingPath );
% the first two is not file 
% NOTICE, NOT SORTED BY NAME
for fileIndex = 3 : length( dirRecording )
    recordingFileName = dirRecording( fileIndex ); 
    % call openSmile extract the feature 
    % be cautious of space in the command 
    system( ['SMILExtract_Release -C IS09_emotion.conf -I ', setting.recordingPath, recordingFileName, ' -O testFeature.csv' ] );
    
    % determine which utterance/segment the wav belongs to
    recordingFileNameSplit = regexp( a, '_', 'split' );
    [ utteranceIndex, segmentIndex ] = deal( ...
        str2num( recordingFileNameSplit{ 1 } ),... 
        str2num( recordingFileNameSplit{ 2 } ) )...
     
end

end

