% try the parameters of vad 

setting.maxsilence = 0;
setting.minlength = 0;
setting.plothight = 1.5;
setting.frameLen = 1280;

[ recording , Fs ] = audioread( 'Ses01F_impro01.wav' );

for maxsilence = 10
    for minlength = 25
        for frameLen = 1280
            setting.maxsilence = maxsilence;
            setting.minlength = minlength;
            setting.frameLen = frameLen;
            setting.plothight = setting.plothight + 0.01; 
            VoiceActivityDetection( recording, Fs, setting);
        end
    end
end
