clear ;
close all ;
clc ;
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
M2021 = serial(port,'Timeout',150) ;
fopen(M2021) ;
%% parameters
PreP300Dur = 0.1 ;
PostP300Dur = 0.7 ;
PreErrDur = 0 ;
PostErrDur = 1 ;
LP = 0.1 ;
HP = 30 ;
needed_rep = 3;
Features = 'CNN3D real';
classifier =  'CNN'; % 'CNN' 'SVM' 'CNN+SVM' 'act'
net_P300 = load('net_P300');
net_P300 = net_P300.net ;
net_Errp = load('net_Errp');
net_Errp = net_Errp.net ;
input = 'user' ; % 'user' 'classifier'
i = 0;
while (1)
    i = i+1
    
    %     address = fscanf('COM3');
    j = 0;
    address = [];
    while isempty(address)
        address = fscanf(M2021);
        j = j+1
    end
    address = address(1:end-1) ;
    data = load(address);
    % err or p300
    sig = SignalNameCompare(address);
    switch sig
        case 'P300'
            switch input
                case 'classifier'
                    data = DataExtractor(data,'P300',PreP300Dur,PostP300Dur,LP,HP) ;
                    data = DataTransform(data,Features);
                    y = KeyEvaluator(net_P300,data,needed_rep,classifier) ;
                case 'user'
                    prompt = {'Enter Row/Colomn number'};
                    dlg_title = 'Input';
                    num_lines = 1;
                    def = {''};
                    answer = inputdlg(prompt,dlg_title,num_lines,def);
                    y = answer{1} ;
            end
        case 'Errp'
            switch input
                case classifier
                    data = DataExtractor(data,'Errp',PreErrDur,PostErrDur,LP,HP) ;
                    data = DataTransform(data,Features);
                    y = ErrEvaluator(net_Errp,data,classifier,varargin);
                    y = -1;
                case 'user'
                    prompt = {'Enter Error mode 0 / 1'};
                    dlg_title = 'Input';
                    num_lines = 1;
                    def = {''};
                    answer = inputdlg(prompt,dlg_title,num_lines,def);
                    y = answer{1} ;
                    
            end
    end
    % send
    
    fprintf(M2021,num2str(y));
    
    
end
% fclose(M2021)
