function y = DataExtractor(data,PreErrDur,PostErrDur...
    ,PreP300Dur,PostP300Dur,LP,HP)

%% data loading
signal = data.signal ;
StartStop = data.StartStop ;
label = data.label ;
% info
fs = 256 ;
n_rep = 3;
%% range equalization
 signal = signal * (0.001) ;
% signal = zscore(signal')' ;

%% useful information
 signal = signal(2:end,:)' ;
% %% power line artifact cancelation
% [b,a]=butter(4,[49.5 50.5]/(fs/2),'stop');       % butterworth bandpass filter
% signal = filtfilt(b,a,signal) ;
%% filtering
        [b,a]=butter(4,[LP HP]/(fs/2),'bandpass');       % butterworth bandpass filter
%         signal = filter(b,a,signal) ;
        signal = filtfilt(b,a,signal) ;

%% eyeblink extraction
signal = EyeBlinkRemove(signal(:,1:end-1),signal(:,end),'sub') ;

%% CAR
ComAvg = mean(signal,2) ;
signal = signal - repmat(ComAvg,1,8) ;
%% channel sorting
signal = [signal;zeros(fs,size(signal,2))];
%% trial extraction
TrialP300 = [] ;
TrialErr = [] ;
for i = 2:length(StartStop)
    if StartStop(2,i) == 1 && StartStop(2,i-1) == 0
        TrialP300 = cat(3,TrialP300,signal(i+fix(PreP300Dur*fs):i+fix(fs*PostP300Dur),:)) ;
    elseif StartStop(2,i) == 2 && StartStop(2,i-1) == 0
        TrialErr = cat(3,TrialErr,signal(i+fix(PreErrDur*fs):i+fix(fs*PostErrDur),:)) ;
    end
end
%% label generation
k = 0 ;
LabelP300 = nan(1,size(TrialP300,3)) ;
m = 1 ;
for i = 2:length(label)

    n_key = length(label{i,2})/n_rep ;

    
    for j = 1:length(label{i,2})
        if label{i,2}(j) == label{i,3}
            LabelP300(m) = 1 ;
        else
            LabelP300(m) = 0 ;
        end
         m = m+1 ;
    end
         k = k + n_key*n_rep ;
end

%% background noise cancelation
%  TrialP300 = EEGRemove(TrialP300,LabelP300,'NonTarget') ;
%% output preparing
% pre allocation
y = cell(size(label));
y(1,:) = {'rep1','rep2','rep3','Err'};
y = cat(2,label,y) ;
% data saving
k=1;
for i = 2:length(label)
    y{i,8} = TrialErr(:,:,i-1) ; % errors
    n_key = length(label{i,2})/n_rep ;

    for j = 1: n_key
        y{i,5}{j} = TrialP300(:,:,k) ;
        y{i,6}{j} = TrialP300(:,:,k+n_key) ;
        y{i,7}{j} = TrialP300(:,:,k+(2*n_key)) ;
        k=k+1 ;
    end
    k = k+((n_rep-1)*n_key) ;
end


end