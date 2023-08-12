%% gui
function varargout = keyboard1(varargin)
clc ;

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @keyboard1_OpeningFcn, ...
    'gui_OutputFcn',  @keyboard1_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function keyboard1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% save input variables from start function
if nargin>3
    handles.pr = varargin{1} ;
end
% start label
handles.pr.StartFlag = 0 ;
% target sentence
handles.TR = handles.pr.Target ;
% key information
handles.key = KeyDeffine(handles.pr.mod_O) ;
% file address
[FullPath,~,~] = fileparts(which(mfilename));
handles.pr.path = GiveFirstFolers(FullPath,1) ;
% label information
% output arguments cl1 = R/C cl2=perm cl3=tr cl4=errflag
switch handles.pr.mod_O
    case 'Offline'
        handles.label = cell(1,4) ;
        handles.label{1,1} = 'R/C' ;
        handles.label{1,2} = 'permutation' ;
        handles.label{1,3} = 'target' ;
        handles.label{1,4} = 'ErrLabel' ;
        
    case 'Online'
        handles.label = cell(1,4) ;
        handles.label{1,1} = 'R/C' ;
        handles.label{1,2} = 'permutation' ;
        handles.label{1,3} = 'predicted P300' ;
        handles.label{1,4} = 'ErrLabel' ;
end

% serial port
switch handles.pr.mod_O
    case 'Online'
        %% creating com port
        available_ports = instrhwinfo ('serial');
        ports = available_ports.AvailableSerialPorts;
        %% giving port
        string = 'Enter port name Avi:';
        for i = 1:length(ports)
            string = cat(2,string,[ports{i},' ']);
        end
        prompt = {string};
        dlg_title = 'Input';
        num_lines = 1;
        def = {''};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        port = answer{1} ;
        %% creating serial obj
        handles.pr.SerialPort = serial(port,'Timeout',150) ;
        fopen(handles.pr.SerialPort) ;
        % port = 'COM2' fclose(ans)
        
end
% making folders
path = handles.pr.path ;
% if isdir([path,'\data'])
%     rmdir([path,'\data']);
% end
if strcmp(handles.pr.mod_O,'Online')
    if ~isdir([path,'\data'])
        mkdir(path,'data');
        mkdir([path,'\data'],'Online');
        mkdir([path,'\data\Online'],'P300');
        mkdir([path,'\data\Online'],'Errp');
        
    end
end
guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = keyboard1_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% my code
% key positions
positioner(handles.key,handles.pr.XStart,handles.pr.YStart,handles.pr.KeySize,handles.pr.StKeySize) ;
% key colors
ColorSet(handles.key,[1,1,1],[0,0,0],[0.2,0.2,0.2],[0.2,0.2,0.2]);
%% loading stimulus images
[ path,~,~] = fileparts(which(mfilename)) ;
fullpath = [path,'\img'] ;
files = dir(fullpath) ;
for i = 3: length(files)
    handles.pr.imgs{i-2} = imread([fullpath,'\',files(i).name]) ;
end
guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%
switch handles.pr.mod_O
    %% online
    case 'Online'
        switch handles.pr.mod_sig
            case 'SSMVEP'
                error('not implemented!') ;
            case 'SSVEP'
                error('not implemented!') ;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 'P300'
                
                term = 1 ;
                while term
                    if ~handles.pr.StartFlag
                        [Start , permut]=RowSelect(handles.pr,handles.key) ;
                        if Start == 0
                            handles.pr.StartFlag = ~handles.pr.StartFlag ;
                            TurnOnOffView();
                        end
                        % label info
                        handles.label = LabelSave(handles.label,'R',permut,Start,'No',handles.pr.mod_O,handles.pr.path) ;
                        % row selection
                    else
                        while handles.pr.StartFlag
                            [R , permut]=RowSelect(handles.pr,handles.key) ;
                            if strcmp(handles.pr.mod_hyb,'Errp')
                                % err detect
                                E = ErrDetect(handles.pr.SimFlag,handles.key,'Row',R,nan,handles.pr.dur_err,'Online',handles.pr.path,handles.pr.SerialPort) ;
                                % label info
                                handles.label = LabelSave(handles.label,'R',permut,R,E,handles.pr.mod_O,handles.pr.path) ;
                                % if we had error potential we do row sel again
                                while E == 1
                                    [R,permut] = RowSelect(handles.pr,handles.key) ;
                                    E = ErrDetect(handles.pr.SimFlag,handles.key,'Row',R,nan,handles.pr.dur_err,'Online',handles.pr.path,handles.pr.SerialPort) ;
                                    % label info
                                    handles.label = LabelSave(handles.label,'R',permut,R,E,handles.pr.mod_O,handles.pr.path);
                                end
                            else
                                handles.label = LabelSave(handles.label,'R',permut,R,'None',handles.pr.mod_O,handles.pr.path) ;
                            end
                            % check start
                            if R == 0
                                handles.pr.StartFlag = ~handles.pr.StartFlag ;
                                TurnOnOffView();
                                continue ;
                            end
                            
                            % colomn selection
                            [C,permut] = ColomnSelect(handles.pr,handles.key,R);
                            if strcmp(handles.pr.mod_hyb,'Errp')
                                
                                % err detect
                                E = ErrDetect(handles.pr.SimFlag,handles.key,'Colomn',R,C,handles.pr.dur_err,'Online',handles.pr.path,handles.pr.SerialPort) ;
                                % label info
                                handles.label = LabelSave(handles.label,'C',permut,C,E,handles.pr.mod_O,handles.pr.path);
                                
                                % if we had error potential we do colomn sel again
                                while E==1
                                    [C,permut] = ColomnSelect(handles.pr,handles.key,R);
                                    E = ErrDetect(handles.pr.SimFlag,handles.key,'Colomn',R,C,handles.pr.dur_err,'Online',handles.pr.path,handles.pr.SerialPort) ;
                                    % label info
                                    handles.label = LabelSave(handles.label,'C',permut,C,E,handles.pr.mod_O,handles.pr.path) ;
                                end
                                
                            else
                                handles.label = LabelSave(handles.label,'C',permut,C,'None',handles.pr.mod_O,handles.pr.path) ;
                            end
                            % check start
                            if C == 0
                                handles.pr.StartFlag = ~handles.pr.StartFlag ;
                                TurnOnOffView();
                                continue ;
                            end
                            WordSelect(handles.key,R,C) ;
                        end
                    end
                    
                    
                end
                
                
                
                
        end
        
        
        
        %% offline
    case 'Offline'
        % find target coding
        Code = DecodeTR(handles.key,handles.TR) ;
        [RCCode , ERRCode] = ERRLabelGen(handles.key,Code,handles.pr.ErrRatio) ;
        switch handles.pr.mod_sig
            case 'SSMVEP'
                error('not implemented!') ;
            case 'SSVEP'
                error('not implemented!') ;
                %% p300
            case 'P300'
                L = length(handles.TR);
                
                for i = 1:L
                    
                    % row selection
                    
                    [~ , permut]=RowSelect(handles.pr,handles.key) ;
                    if strcmp(handles.pr.mod_hyb,'Errp')
                        R = RCCode(i,1) ;
                        % err detect
                        ErrDetect(handles.pr.SimFlag,handles.key,'Row',R,nan,handles.pr.dur_err) ;
                        E = ERRCode(i,1) ;
                        % label info
                        handles.label = LabelSave(handles.label,'R',permut,Code(i,1),E,handles.pr.mod_O) ;
                        %                     guidata(hObject, handles);
                        
                        % if we had error potential we do row sel again
                        if E == 1
                            [~,permut] = RowSelect(handles.pr,handles.key) ;
                            R = Code(i,1) ;
                            ErrDetect(handles.pr.SimFlag,handles.key,'Row',R,nan,handles.pr.dur_err) ;
                            % label info
                            handles.label = LabelSave(handles.label,'R',permut,Code(i,1),0,handles.pr.mod_O);
                            %                         guidata(hObject, handles);
                        end
                    else
                        R = Code(i,1) ;
                        handles.label = LabelSave(handles.label,'R',permut,R,'None',handles.pr.mod_O);
                    end
                    % colomn selection
                    [~,permut] = ColomnSelect(handles.pr,handles.key,R);
                    if strcmp(handles.pr.mod_hyb,'Errp')
                        C = RCCode(i,2) ;
                        
                        % err detect
                        ErrDetect(handles.pr.SimFlag,handles.key,'Colomn',R,C,handles.pr.dur_err) ;
                        E = ERRCode(i,2) ;
                        % label info
                        handles.label = LabelSave(handles.label,'C',permut,Code(i,2),E,handles.pr.mod_O);
                        %                     guidata(hObject, handles);
                        
                        
                        % if we had error potential we do colomn sel again
                        
                        if E==1
                            [~,permut] = ColomnSelect(handles.pr,handles.key,R);
                            C = Code(i,2) ;
                            ErrDetect(handles.pr.SimFlag,handles.key,'Colomn',R,C,handles.pr.dur_err) ;
                            % label info
                            handles.label = LabelSave(handles.label,'C',permut,Code(i,2),0,handles.pr.mod_O) ;
                        end
                    else
                        C = Code(i,2) ;
                        handles.label = LabelSave(handles.label,'C',permut,C,'None',handles.pr.mod_O) ;
                    end
                    WordSelect(handles.key,R,C) ;
                end
        end
        if handles.pr.SimFlag == 0
            set_param('EEG_Record','SimulationCommand','Stop');     % stop simulink
        end
        
end
%% output
varargout{2} = handles.label ;

