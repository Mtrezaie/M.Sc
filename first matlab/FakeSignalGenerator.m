function [signal , StartStop] = FakeSignalGenerator(mod_sig,varargin)

t0 = 1;
t1 = 2;
fs = 256;

switch mod_sig
    
    case 'P300'
        permut = varargin{1} ;
        St_Dur = varargin{2} ;
        ISI = varargin{3} ;
        ISI_vect = zeros(1,fix(ISI*fs)) ;
        St_Dur_vect = ones(1,fix(St_Dur*fs)) ;
        vect = [];
        L = length(permut) ;
        for i = 1:L
            vect = cat(2,vect,ISI_vect);
            vect = cat(2,vect,St_Dur_vect);
        end
        vect = cat(2,vect,St_Dur_vect);
        t_total = fix((L+1)*(ISI)+L*St_Dur);
        time_samp = linspace(0,t_total,length(vect));        
        StartStop = [time_samp;vect] ; 
        signal = [time_samp;rand(16,length(vect))];
            
    case 'Errp'
    
        time_samp = linspace(0,t0*2+t1,(t0*2+t1)*fs);
        StartStop = [time_samp;zeros(1,fs*t0),2*ones(1,fs*t1),zeros(1,fs*t0)] ;
        signal = [time_samp;rand(16,(t0*2+t1)*fs)] ;
    
end

end