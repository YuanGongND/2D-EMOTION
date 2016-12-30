[ recording, Fs ] = audioread ( 'Ses01F_impro01.wav' );

setting.maxsilence = 10;
setting.minlength = 20;
setting.plothight = 1.5;
setting.frameLen = 1280;
setting.segmentLength = 0.5*16000; 

 timeStampUtterance = VoiceActivityDetection( recording, Fs, setting );
 timeStampSegment  = Segmentation ( timeStampUtterance, setting );