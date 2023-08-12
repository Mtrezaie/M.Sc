%[x,y] = plotter1(signal,label,StartStop);

function [TrialP300 , P300_label] = plotter1(signal,label,StartStop)
% innformation
close all;
channels = {'Fz','Cz','P3','Pz','P4','Po7','Po8','Oz','eyeblink'} ;
PreErrDur = 0.1 ;
PostErrDur = 0.8 ;
fs = 256 ;
PostP300Dur = 0.8 ;
PreP300Dur = 0.1 ;
% range equalization
% signal = signal * (0.001) ;
% eyeblink extraction
eyeblink = 0.2*signal(end,:) ;
eyeblink = repmat(eyeblink,size(signal,1)-1,1) ;
signal(2:end,:) = signal(2:end,:) - eyeblink ;

% notch filtering
f = fir1(50,[49.5 50.5]/(fs/2),'stop') ;
sig = filter(f,1,signal(2:end,:)') ;
% sig = signal(2:end,:)' ;

% band pass filtering butterworth
[b,a] = butter(3,[0.1 10]/(fs/2),'bandpass'); 
sig = filter(b,a,sig) ;
% %% downsampling
% rate = 4 ;
% fs = fs/rate ;
% sig = downsample(sig,rate) ;
% StartStop = downsample(StartStop',rate)' ;
%% trial extraction
TrialP300 = [] ;
TrialErr = [] ;
for i = 2:length(StartStop)
    if StartStop(2,i) == 1 && StartStop(2,i-1) == 0
       TrialP300 = cat(3,TrialP300,sig(i-floor(fs*PreP300Dur):i+floor(fs*PostP300Dur),:)) ;
    elseif StartStop(2,i) == 2 && StartStop(2,i-1) == 0
TrialErr = cat(3,TrialErr,sig(i-floor(PreErrDur*fs):i+floor(fs*PostErrDur),:)) ;
    end
end
% zscore
TrialP300 = zscore(TrialP300) ;
TrialErr = zscore(TrialErr) ;

% filtering
% [b,a]=butter(4,[0.1 30]/(fs/2),'bandpass');       % butterworth bandpass filter
% TrialP300 = filter(b,a,TrialP300) ;
% TrialErr = filter(b,a,TrialErr) ;

%% target vs non target
% label generation
P300_label = [] ;
for i = 2:size(label,1)
    for j = 1:length(label{i,2})
        if label{i,3} == label{i,2}(j)
            P300_label = cat(1,P300_label,1);
        else
            P300_label = cat(1,P300_label,0);
        end
    end
end
P300_label = logical(P300_label) ;
Err_label = logical(cell2mat(label(2:end,4))) ;
% balancing
[TrialP300 , P300_label] = DataSetBalance1(TrialP300 , P300_label) ;
[TrialErr , Err_label] = DataSetBalance1(TrialErr , Err_label) ;

% p300
P300_target = TrialP300(:,:,P300_label) ;
P300_nontarget = TrialP300(:,:,~P300_label) ;
P300_target_mean =  (mean(P300_target,3)) ;
P300_nontarget_mean =  (mean(P300_nontarget,3)) ;
% Err
Err = TrialErr(:,:,Err_label) ;
Err_mean =  (mean(Err,3)) ;
nonErr = TrialErr(:,:,~Err_label) ;
nonErr_mean = (mean(nonErr,3)) ;
%% plotting
t_p300 = linspace(-PreP300Dur,PostP300Dur,size(P300_target_mean,1));
t_Err = linspace(-PreErrDur,PostErrDur,size(Err_mean,1));


figure('name','p300 ') ;
for i = 1 :length(channels) 
% p300
subplot(3,3,i) ;
plot(t_p300,P300_target_mean(:,i),'r');
hold on ;
plot(t_p300,P300_nontarget_mean(:,i),'b') ;
% cue time 
hold on ;
m1 = min ( [P300_target_mean(:,i) ; P300_nontarget_mean(:,i)] ) ;
m2 = max ( [P300_target_mean(:,i) ; P300_nontarget_mean(:,i)] ) ;
plot(zeros(1000,1),linspace(m1,m2,1000) ,'LineWidth',2,'Color','K') ;
ylim ([m1,m2]) ;
xlim ([-1*PreP300Dur,PostP300Dur]) ;
title([channels{i}]) ;
end
legend('target','non target','cue','Location','SouthEastOutside') ;

figure('name','ERRP ') ;
for i = 1 :length(channels) 
% err 
subplot(3,3,i) ;
plot(t_Err,Err_mean(:,i),'r');
hold on ;
plot(t_Err,nonErr_mean(:,i),'b') ;
hold on ;
m1 = min([Err_mean(:,i);nonErr_mean(:,i)]) ;
m2 = max([Err_mean(:,i);nonErr_mean(:,i)]) ;
plot(zeros(1000,1),linspace(m1,m2,1000) ,'LineWidth',2,'Color','K') ;
ylim ([m1,m2]) ;
xlim ([-1*PreErrDur,PostErrDur]) ;
title([channels{i}]);

end
legend('ERRP','free','cue','Location','SouthEastOutside') ;
%% mean of all
Err_mean_2 = mean(Err_mean,2) ;
nonErr_mean_2 = mean(nonErr_mean,2) ;

P300_target_mean_2 = mean(P300_target_mean,2); 
P300_nontarget_mean_2 = mean(P300_nontarget_mean,2); 

figure('name','p300 ') ;
% p300
plot(t_p300,P300_target_mean_2,'r');
hold on ;
plot(t_p300,P300_nontarget_mean_2,'b') ;
% cue time 
hold on ;
m1 = min ( [P300_target_mean_2 ; P300_nontarget_mean_2] ) ;
m2 = max ( [P300_target_mean_2 ; P300_nontarget_mean_2] ) ;
plot(zeros(1000,1),linspace(m1,m2,1000) ,'LineWidth',2,'Color','K') ;
ylim ([m1,m2]) ;
xlim ([-1*PreP300Dur,PostP300Dur]) ;
legend('target','non target','cue','Location','SouthEastOutside') ;

figure('name','ERRP ') ;
% err 
plot(t_Err,Err_mean_2,'r');
hold on ;
plot(t_Err,nonErr_mean_2,'b') ;
hold on ;
m1 = min([Err_mean_2;nonErr_mean_2]) ;
m2 = max([Err_mean_2;nonErr_mean_2]) ;
plot(zeros(1000,1),linspace(m1,m2,1000) ,'LineWidth',2,'Color','K') ;
ylim ([m1,m2]) ;
xlim ([-1*PreErrDur,PostErrDur]) ;
legend('ERRP','free','cue','Location','SouthEastOutside') ;

