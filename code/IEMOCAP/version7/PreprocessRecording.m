function [  ] = PreprocessRecording( recordingName, setting )
% Preprocessing the recording includes voice activity detecttion ( removing 
% silence), segmentation (cut into processing unit), extract acoustic
% features. 

%% Default setting 
if nargin == 0
    recordingName = 'Ses01F_impro01.wav';
    DefaultSetting;
end

if nargin == 1
    % default setting 
    DefaultSetting;
end

%% Read Audio
[ recording, sampleRate ] = audioread( recordingName );

%% Voice activity detection
timeStampUtterance = VoiceActivityDetection( recording, sampleRate, setting );
csvwrite( 'timeStampUtterance.csv', timeStampUtterance );

%% Segmentation
timeStampSeg = Segmentation( timeStampUtterance, setting );
csvwrite( 'timeStampSeg.csv', timeStampSeg );

%% Feature extraction
%FeatureExtraction( recording, timeStampSeg );

end

