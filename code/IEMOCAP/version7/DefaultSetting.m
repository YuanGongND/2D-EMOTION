%% default vad and segmentation setting
setting.maxSilence = 10;
setting.minLength = 20;
setting.plothight = 1.5;
setting.frameLength = 1280;
setting.segmentLength = 0.5*16000;

%% default file path setting
setting.recordingPath = './tempfile/wav'
setting.recordingName = 'Ses01F_impro01.wav'
setting.featureFileName = './tempfile/feature/testFeature.csv'
setting.timeStampUtterancePath = './tempfile/timestamp/timeStampUtterance.csv'
setting.timeStampSeg = './tempfile/timestamp/timeStampSeg.csv'
setting.timeStampMapping = './tempfile/timestamp/timeStampMapping.csv'
setting.actiResult = './tempfile/result/activationresult.csv'
setting.valeResult = './tempfile/result/valenceresult.csv'
setting.sampleAnimation = 'EmotionAnimation.mp4'

%% default feature setting
setting.activationFeatureIndex = [2,4,7,9,11,19,21,27,31,37,39,44,48,50,67,84,91,99,103,105,128,133,134,148,156,163,165,167,194,195,196,213,216,219,225,231,237,240,249,261,264,276,285,307,309,324,326,343,349,363];
setting.valenceFeatureIndex = [10,20,60,68,79,96,109,120,128,140,159,168,203,211,212,213,216,229,231,235,237,238,253,259,266,271,273,284,285,295,300,307,309,321,324,333,348,357];

%% default model setting
setting.predictionAlgorithm = 'RT' % regression tree