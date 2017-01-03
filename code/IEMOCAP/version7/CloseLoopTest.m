% scaffold for building the whole system

% deploy default settings
DefaultSetting;

% preprocess the original recording
[ timeStampUtterance, timeStampSeg, timeStampMapping ] = PreprocessRecording( recordingName, setting );

% make prediction 
[ resultActi, resultVale ] = PredictEmotion( setting );

% visualization

