function varargout = ParadigmStart(varargin)
clc;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ParadigmStart_OpeningFcn, ...
    'gui_OutputFcn',  @ParadigmStart_OutputFcn, ...
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ParadigmStart_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.Pr.dur_st = 100 ;
handles.Pr.dur_ISI = 70 ;
handles.Pr.n_rep = 3;
handles.Pr.dur_SSVEP = 2000 ;
handles.Pr.Monitor_refresh_rate = 200 ;
handles.Pr.mod_sig = 'P300';
handles.Pr.mod_hyb = 'None';
handles.Pr.dur_err = 1000 ;
handles.Pr.mod_O = 'Offline';
handles.Pr.mod_T = 'Train';
handles.Pr.ErrRatio = 0.3;
handles.Pr.XStart = 60 ;
handles.Pr.YStart = 545 ;
handles.Pr.KeySize = 50;
handles.Pr.StKeySize = 100 ;
handles.Pr.Target = 'brain computer interface' ;
handles.Pr.waits = 1000 ;
handles.Pr.SimFlag = 0 ;
guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Outputs from this function are returned to the command line.
function varargout = ParadigmStart_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_SSMVEP_Callback(hObject, eventdata, handles)
set(handles.PN_1,'visible','on') ;
set(handles.PN_11,'Title','duration');
set(handles.PN_12,'visible','on');
set(handles.PN_12,'Title','Monitor refresh rate');
set(handles.PN_13,'visible','off');
handles.Pr.mod_sig = 'SSVEP' ;
set(handles.ED_P1,'string','2000') ;
set(handles.ED_P2,'string','200') ;

guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function RB_SSVEP_Callback(hObject, eventdata, handles)
set(handles.PN_1,'visible','on') ;
set(handles.PN_11,'Title','duration');
set(handles.PN_12,'visible','on');
set(handles.PN_12,'Title','Monitor refresh rate');
set(handles.PN_13,'visible','off');
handles.Pr.mod_sig = 'SSVEP' ;
set(handles.ED_P1,'string','2000') ;
set(handles.ED_P2,'string','200') ;

guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_P300_Callback(hObject, eventdata, handles)
set(handles.PN_1,'visible','on') ;
set(handles.PN_12,'visible','on');
set(handles.PN_13,'visible','on');
set(handles.PN_11,'Title','Stimulus duration');
set(handles.PN_12,'Title','ISI');
set(handles.PN_13,'Title','Repetition');
handles.Pr.mod_sig = 'P300' ;
set(handles.ED_P1,'string','100') ;
set(handles.ED_P2,'string','70') ;

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_P1_Callback(hObject, eventdata, handles)
switch handles.Pr.mod_sig
    case 'P300'
        handles.Pr.dur_st = str2double(get(hObject,'string')) ;
    case 'SSVEP'
        handles.Pr.dur_SSVEP = str2double(get(hObject,'string')) ;
    case 'SSMVEP'
        handles.Pr.dur_SSVEP = str2double(get(hObject,'string')) ;
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_P1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_P2_Callback(hObject, eventdata, handles)

switch handles.Pr.mod_sig
    case 'P300'
        handles.Pr.dur_ISI = str2double(get(hObject,'string')) ;
    case 'SSVEP'
        handles.Pr.Monitor_refresh_rate = str2double(get(hObject,'string')) ;
    case 'SSMVEP'
        handles.Pr.Monitor_refresh_rate = str2double(get(hObject,'string')) ;
        
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_P2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ED_P3_Callback(hObject, eventdata, handles)
switch handles.Pr.mod_sig
    case 'P300'
        handles.Pr.n_rep = str2double(get(hObject,'string')) ;
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_P3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_ERRP_Callback(hObject, eventdata, handles)
set(handles.PN_2,'visible','on') ;
handles.Pr.mod_hyb = 'Errp' ;
guidata(hObject,handles) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_none_Callback(hObject, eventdata, handles)
set(handles.PN_2,'visible','off') ;
handles.Pr.mod_hyb = 'None' ;
guidata(hObject,handles) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_errdur_Callback(hObject, eventdata, handles)
switch handles.Pr.mod_hyb
    case 'ERRP'
        handles.Pr.dur_err = str2double(get(hObject,'string')) ;
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_errdur_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_online_Callback(hObject, eventdata, handles)
set(handles.PN_31,'visible','on') ;
set(handles.PN_32,'visible','off');
handles.Pr.mod_O = 'Online' ;
set(handles.PN_Target,'visible','off') ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_offline_Callback(hObject, eventdata, handles)
set(handles.PN_31,'visible','off') ;
set(handles.PN_32,'visible','on');
handles.Pr.mod_O = 'Offline' ;
set(handles.PN_Target,'visible','on') ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrRatio_Callback(hObject, eventdata, handles)
handles.Pr.ErrRatio = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrRatio_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_train_Callback(hObject, eventdata, handles)
handles.Pr.mod_T = 'Train' ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RB_test_Callback(hObject, eventdata, handles)
handles.Pr.mod_T = 'Test' ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function tog_Callback(hObject, eventdata, handles)
v = get(hObject,'value') ;
if v == 0
    set(hObject,'String','Turn on') ;
    set(hObject,'Backgroundcolor',[0.941 , 0.941 , 0.941]) ;
    handles.Pr.SimFlag = 0 ;
elseif v==1
    set(hObject,'String','Sim mode') ;
    set(hObject,'Backgroundcolor','g') ;
    
    handles.Pr.SimFlag = 1 ;
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_target_Callback(hObject, eventdata, handles)
handles.Pr.Target = get(hObject,'string') ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_target_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_StKeySize_Callback(hObject, eventdata, handles)
handles.Pr.StKeySize = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_StKeySize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_KeySize_Callback(hObject, eventdata, handles)
handles.Pr.KeySize = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_KeySize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_Y_Callback(hObject, eventdata, handles)
handles.Pr.YStart = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_Y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_X_Callback(hObject, eventdata, handles)
handles.Pr.XStart = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_X_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_Waits_Callback(hObject, eventdata, handles)
handles.Pr.waits = str2double(get(hObject,'string')) ;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ED_Waits_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PB_Start_Callback(hObject, eventdata, handles)
switch handles.Pr.mod_sig
    case 'P300'
        [~, label] = keyboard1(handles.Pr);
        if handles.Pr.SimFlag == 0 && strcmp(handles.Pr.mod_O,'Offline')
%             save('label');
            load('signal.mat') ;
            load('StartStop.mat') ;
            plotter1(signal,label,StartStop) ;
            %% saving data
            % name
            prompt = {'Enter subject name','Enter sesion number','Enter Run number'};
            dlg_title = 'Input';
            num_lines = 1;
            def = {'','',''};
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            data_name = [answer{1},'_session',answer{2},'_Run',answer{3}];
            % path
            [FullPath,~,~] = fileparts(which(mfilename));
            path = [GiveFirstFolers(FullPath,1),'data'] ;
            if ~isdir([path,'\Offline'])
                mkdir(path,'Offline');
            end
            address = [path,'\Offline'] ;
            save([address,'\',data_name],'label','signal','StartStop') ;
        end
        
    case 'SSVEP'
        
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PB_Stop_Callback(hObject, eventdata, handles)
if handles.Pr.SimFlag == 0
                    set_param('EEG_Record','SimulationCommand','Stop');     % stop simulink
end
close all;
