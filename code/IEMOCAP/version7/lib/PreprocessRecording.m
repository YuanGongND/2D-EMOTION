function [ timeStampUtterance, timeStampSeg, timeStampMapping ]...
    = PreprocessRecording( setting )
% Preprocessing the recording includes voice activity detecttion ( removing 
% silence), segmentation (cut into processing unit), extract acoustic
% features. 

% %% Default setting 
% if nargin < 2
%     % default setting 
%     DefaultSetting;
% end
% 
% if nargin < 1
%     % default testfile
%     recordingName = setting.recordingName;
% end

%% Read Audio
[ recording, sampleRate ] = audioread( setting.recordingName );

%% Voice activity detection
timeStampUtterance = VoiceActivityDetection( recording, sampleRate, setting );
csvwrite( setting.timeStampUtterance, timeStampUtterance );

%% Segmentation
timeStampSeg = Segmentation( recording, sampleRate, timeStampUtterance, setting );
csvwrite( setting.timeStampSegment, timeStampSeg );

%% Feature extraction
% keep record timeStamp of each segment 
[ timeStampMapping ] = FeatureExtraction( setting );

end

