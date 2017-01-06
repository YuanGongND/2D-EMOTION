%unix( './SMILExtract -C IS09_emotion.conf -I Ses01F_impro01_F000.wav -O testFeature.csv' );
%system( 'SMILExtract_Release -C IS09_emotion.conf -I Ses01F_impro01.wav -O testFeature.csv' );

subplot(2,1,1);
scatter( 1 , 2, 20, 'r', 'filled' );
hold on;

subplot(2,1,2);
scatter( 2 , 3, 20, 'r', 'filled' );
hold on;

subplot(2,1,1);
scatter( 2 , 4, 20, 'r', 'filled' );