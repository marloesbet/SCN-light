% load SCN timeseries as one vector (1 column)
SCN_ts=readmatrix('SCN_ts.txt');
SCN_ts=SCN_ts(:,1);

% subtract the mean from each value to normalize timeseries
mean_SCN=mean(SCN_ts);
%SCN_demeaned=SCN-mean_SCN;

% demean the timeseries
SCN_demeaned=SCN_ts-mean_SCN;

%optional normalization (also standardizes variance)
%SCN_normalized=SCN/mean_SCN;

% select the part of the timeseries that you want to use
% starting at 51 skips the first 3 dark/light cycles
SCN_trimmed=SCN_demeaned(51:146,:);

% create empty matrix to save perc change values in
avg_bold=[];

% Set counter to keep track of from where the epoch is selected
start=1;

for i=1:12
    dark_epoch=SCN_trimmed(start:start+7); % select 8 volumes per epoch
    light_epoch=SCN_trimmed(start+8:start+15);
    
    %Store means per epoch and calculate % signal change
    avg_bold(i,1)=mean(dark_epoch);
    avg_bold(i,2)=mean(light_epoch);
    
    % perc change in light period relative to dark period stored in col3
    avg_bold(i,3)=((avg_bold(i,2)-avg_bold(i,1))/avg_bold(i,1))*100;
    
    % perc change in dark period relative to baseline/mean stored in col4
    avg_bold(i,4)=(((avg_bold(i,1) - mean_SCN)/mean_SCN)*100);
    
    % perc change in light period relative to baseline/mean stored in col5
    avg_bold(i,5)=(((avg_bold(i,2) - mean_SCN)/mean_SCN)*100);
    
    % skip one volume per dark-light cycle bc it is located right at the
    % switch between dark and light (doesn't belong to either)
    start=start+2;
end
    
% Take mean of all perc changes across the time series
perc_change_lightvdark=mean(avg_bold(:,3));
perc_change_darkvmean=mean(avg_bold(:,4));
perc_change_lightvmean=mean(avg_bold(:,5));

% plot the fourth cycle of dark-light epochs
SCN_plot=SCN_trimmed(1:26);
plot(SCN_plot);