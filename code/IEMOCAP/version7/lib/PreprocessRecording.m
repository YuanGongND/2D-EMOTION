function [ timeStampUtterance, timeStampSeg, timeStampMapping ]...
    = PreprocessRecording( recordingName, setting )
% Preprocessing the recording includes voice activity detecttion ( removing 
% silence), segmentation (cut into processing unit), extract acoustic
% features. 

%% Default setting 
if nargin < 2
    % default setting 
    DefaultSetting;
end

if nargin < 1
    % default testfile
    recordingName = 'Ses01F_impro01.wav';
end

%% Read Audio
[ recording, sampleRate ] = audioread( recordingName );

%% Voice activity detection
timeStampUtterance = VoiceActivityDetection( recording, sampleRate, setting );
csvwrite( '.\tempfile\timestamp\timeStampUtterance.csv', timeStampUtterance );

%% Segmentation
timeStampSeg = Segmentation( recording, sampleRate, timeStampUtterance, setting );
csvwrite( '.\tempfile\timestamp\timeStampSeg.csv', timeStampSeg );

%% Feature extraction
% keep record timeStamp of each segment 
[ timeStampMapping ] = FeatureExtraction( setting );

end

