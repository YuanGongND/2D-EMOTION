function [ output_args ] = FeatureExtraction( setting )
% use openSmile tools to extract emotion related features

dirRecording = dir( setting.recordingPath );
%% the first two is not file 
%% NOTICE, NOT SORTED BY NAME
for fileIndex = 3 : length( dirRecording )
    
end

end

