% scaffold for building the whole system

%% deploy default settings
DefaultSetting;

%% preprocess the original recording
[ timeStampUtterance, timeStampSeg, timeStampMapping ] = PreprocessRecording( );

%% make prediction 
[ resultActi, resultVale ] = PredictEmotion( setting );

%% visualization
EmotionVisualization( setting );

