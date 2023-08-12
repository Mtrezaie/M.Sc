function address = Stimulus(SimFlag,sig,tag,permut,varargin)
% in case p300 varargin should be ST_DUR , ISI
% allocation
address = [];
switch sig
    case 'SSMVEP'
    case 'SSVEP'
    case 'P300'
        dur_st = varargin{1}/1000;
        ISI = varargin{2}/1000 ;
        imgs = varargin{3} ;
        if nargin>7
            mod_O = varargin{4} ;
            path = varargin{5};
        end
        L_imgs = length(imgs) ;
       
        for i = 1:numel(permut)
            set(findobj('tag',deblank(tag(permut(i),:))),'CData',imgs{randperm(L_imgs,1)} );
            
            % make eeg gain 1
            if SimFlag == 0
                set_param('EEG_Record/Subsystem1/Gain1','Gain','1');
            end
            pause(dur_st);
            set(findobj('tag',deblank(tag(permut(i),:))),'CData',[]);
            % make eeg gain 0
            if SimFlag == 0
                set_param('EEG_Record/Subsystem1/Gain1','Gain','0');
            end
            pause(ISI);
        end
        
        if  strcmp(mod_O,'Online')
            if SimFlag == 0
                pause(1);
                set_param('EEG_Record','SimulationCommand','Stop');
                load('signal.mat');
                load('StartStop.mat') ;
            else
                [signal , StartStop] = FakeSignalGenerator('P300',permut,ISI,dur_st);
            end
            % save data
            indx = length(dir([path ,'data\Online\P300','\*.mat' ])) + 1;
            address = [path,'data\Online\P300\',num2str(indx),'.mat'] ;
            save(address,'signal','StartStop','permut','-mat') ;
        end
        
end