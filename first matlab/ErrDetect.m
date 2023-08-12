function y = ErrDetect(SimFlag,key,RCMod,r,c,ErrDur,varargin)
ErrDur2 = 500 ;
% allocate
y = 0 ;

if nargin>6
    mod_O = varargin{1} ;
else
    mod_O = 'Offline';
end
if nargin>7
    path = varargin{2} ;
end
if nargin>8
    SerialPort = varargin{3} ;
end
switch RCMod
    case 'Row'
        % turn every thing off except that row
        % off
        KeyVisible(key.tag,0);
        % on
        tag = [key.tag(key.row==r,:);unique(key.tag_st_r,'rows')] ;
        KeyVisible(tag,1);
        if SimFlag == 0 && strcmp(mod_O,'Online')
            set_param('EEG_Record','SimulationCommand','Start');
        end
        % wait for g.tec
        pause(ErrDur2/1000) ;

        if SimFlag == 0
            set_param('EEG_Record/Subsystem1/Gain1','Gain','2');
        end
        %% color changing rutine
        true_st_tag = unique(key.tag_st_r(key.row==r,:),'rows') ;
        ColorChange(true_st_tag,'green') ;
        
        false_st_tag = unique(key.tag_st_r(key.row~=r,:),'rows') ;
        ColorChange(false_st_tag,[0.3,0.1,0.1]) ;
        
        
        %%
        pause(ErrDur2/1000) ;
        % turning off
        KeyVisible(tag,0);
        %% color off
        ColorChange(true_st_tag,[0.2 , 0.2 , 0.2]) ;
        ColorChange(false_st_tag,[0.2 , 0.2 , 0.2]) ;
        
        if SimFlag == 0
            set_param('EEG_Record/Subsystem1/Gain1','Gain','0');
        end
        % pause
        pause(ErrDur/1000) ;
        if strcmp(mod_O,'Online')
            if SimFlag == 0
            set_param('EEG_Record','SimulationCommand','Stop');
            load('signal.mat');
            load('StartStop.mat') ;
            else
            [signal , StartStop] = FakeSignalGenerator('Errp');
            end
            % save data
            indx = length(dir([path ,'\data\Online\Errp','\*.mat' ])) + 1;
            address = [path,'data\Online\Errp\',num2str(indx),'.mat'] ;
            save(address,'signal','StartStop','-mat') ;
            % processing
            y = GetResp(SerialPort,address);
        end
    case 'Colomn'
        % off
        KeyVisible(key.tag,0);
        % on
        tag = [key.tag(key.row==r & key.colomn==c,:);key.tag_st_cl(key.row==r ,:);key.tag_st_cl(end ,:)] ;
        KeyVisible(tag,1);
         if SimFlag == 0 && strcmp(mod_O,'Online')
            set_param('EEG_Record','SimulationCommand','Start');
         end
          % wait for g.tec
        pause(ErrDur2/1000) ;
        
        if SimFlag == 0
            set_param('EEG_Record/Subsystem1/Gain1','Gain','2');
        end
        
        %% color
        if c == 0 
            r = 0;
        end
        true_st_tag = unique(key.tag_st_cl(key.row==r & key.colomn==c,:),'rows') ;
        ColorChange(true_st_tag,[0.1,0.4,0.1]) ;
        
        false_st_tag = unique(key.tag_st_cl(key.row==r & key.colomn~=c,:),'rows') ;
        ColorChange(false_st_tag,[0.4,0.1,0.1]) ;
        
        
        % error detection
        pause(ErrDur2/1000) ;
        
        % turning off
        KeyVisible(tag,0);
        
        %% color off
        ColorChange(true_st_tag,[0.2 , 0.2 , 0.2]) ;
        ColorChange(false_st_tag,[0.2 , 0.2 , 0.2]) ;
        if SimFlag == 0
            set_param('EEG_Record/Subsystem1/Gain1','Gain','0');
        end
        % pause
        pause(ErrDur/1000) ;
        
        if strcmp(mod_O,'Online')
            if SimFlag == 0
            set_param('EEG_Record','SimulationCommand','Stop');
            load('signal.mat');
            load('StartStop.mat') ;
            else
            [signal , StartStop] = FakeSignalGenerator('Errp');
            end
            % save data
            indx = length(dir([path ,'\data\Online\Errp','\*.mat' ])) + 1;
            address = [path,'data\Online\Errp\',num2str(indx),'.mat'] ;
            save(address,'signal','StartStop','-mat') ;
            % processing
            y = GetResp(SerialPort,address);
        end
       
end
end