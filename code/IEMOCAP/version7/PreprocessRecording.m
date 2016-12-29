function [  ] = PreprocessRecording( recordingName, setting )
% Preprocessing the recording includes voice activity detecttion ( removing 
% silence), segmentation (cut into processing unit), extract acoustic
% features. 

%% Read audio
[ recording, sampleRate ] = audioread( filename );

%% Voice activity detection
timeStampVad = VoiceActivityDetection( recording, sampleRate, setting );

%% Segmentation
timeStampSeg = Segmentation( timeStampVad, setting );

%% Feature extraction
FeatureExtraction( recording, timeStampSeg );

end

