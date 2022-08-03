%Load timeseries and design
SCN1 = importdata('/home/mdbet/scratch/sub-01/ses-1/func/stim/sub-01_SCN_ts.txt');
SCN3 = importdata('/home/mdbet/scratch/sub-03/ses-1/func/stim/lvl1stats_uncorr.feat/sub-03_ses-1_task-light_bold_ica_SCNts.txt');
design = [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0];
design2 = importdata('/home/mdbet/scratch/code/light_ON_OFF.txt');

%Correlation in sub3
[R3,p3] = corrcoef(SCN3,design);
R3 = R3(1,2);
p3 = p3(1,2);

%Correlation in sub1
design = design(1:84);
[R1,p1] = corrcoef(SCN1,design);
R1 = R1(1,2);
p1 = p1(1,2);

%Plot
SCN3 = SCN3(1:84);

SCN1 = SCN1 - mean(SCN1); %mean timeseries opnieuw extracten
SCN3 = SCN3 - mean(SCN3);

x = [1:84];
plot1 = plot(x,design,x,SCN1,x,SCN3);
plot2 = plot(x,design);

A = niftiread('/home/mdbet/scratch/sub-03/ses-1/func/stim/sub-03_ses-1_task-light_bold_topup2.nii.gz');