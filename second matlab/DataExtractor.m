function y = DataExtractor(data,sig,PreDur,PostDur,LP,HP)
%% data loading
signal = data.signal ;
StartStop = data.StartStop ;
if strcmp(sig,'P300')
    permut = data.permut ;
end
% info
fs = 256 ;
n_rep = 3;
%% range equalization
signal = signal * (0.001) ;
%% useful information
signal = signal(2:end,:)' ;
% %% power line artifact cancelation
% [b,a]=butter(6,[40 60]/(fs/2),'stop');       % butterworth bandpass filter
% signal = filter(b,a,signal) ;
%% filtering
[b,a]=butter(4,[LP HP]/(fs/2),'bandpass');       % butterworth bandpass filter
%         signal = filter(b,a,signal) ;
signal = filtfilt(b,a,signal) ;
%% eyeblink extraction
signal = EyeBlinkRemove(signal(:,1:end-1),signal(:,end),'sub') ;

%% CAR
ComAvg = mean(signal,2) ;
signal = signal - repmat(ComAvg,1,size(signal,2)) ;
% %% power line artifact cancelation
% [b,a]=butter(6,[40 60]/(fs/2),'stop');       % butterworth bandpass filter
% signal = filter(b,a,signal) ;

%% channel sorting
signal = [signal;zeros(fs,size(signal,2))];
StartStop = [zeros(2,2),StartStop] ;
%% trial extraction
switch sig
    case 'P300'
        TrialP300 = [] ;
        for i = 2:length(StartStop)
            if StartStop(2,i) == 1 && StartStop(2,i-1) == 0
                TrialP300 = cat(3,TrialP300,signal(i+fix(PreDur*fs):i+fix(fs*PostDur),:)) ;
            end
        end

    case 'Errp'
        for i = 2:length(StartStop)

            if StartStop(2,i) == 2 && StartStop(2,i-1) == 0
                TrialErr = cat(3,TrialErr,signal(i+fix(PreDur*fs):i+fix(fs*PostDur),:)) ;
            end
        end
end
%% output preparing
switch sig
    case 'P300'
        % pre allocation
        y = cell(2,4);
        y(1,:) = {'rep1','rep2','rep3','permut'};
        n_key = length(permut)/n_rep ;
        y{2,4} = permut ;
        for k = 1:n_rep
            for j = 1: n_key
                y{2,k}{j} = TrialP300(:,:,((k-1)*n_key) + j ) ;
            end
        end

    case 'Errp'
        y = squeeze(TrialErr) ;
end




end
