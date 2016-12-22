%% input path
contlabelpath='../../../data/IEMOCAP/feature/version1/numLabel.xlsx';
featurepath='../../../result/IEMOCAPlabel/version1/testfeature.csv';

%% output path 
valencepath='../../../data/IEMOCAP/feature/version1/valenceSelection.xlsx';
arousalpath='../../../data/IEMOCAP/feature/version1/arousalSelection.xlsx';

feature=xlsread(featurepath);
label=xlsread(contlabelpath);

%resultLabel=[resultLabel;valence,dominance,arouse];

valence=label(:,1);
dominance=label(:,2);
arousal=label(:,3);

valenceMatrix=[valence,feature];
arousalMatrix=[arousal,feature];

xlswrite(valencepath,valenceMatrix);
xlswrite(arousalpath,arousalMatrix);
