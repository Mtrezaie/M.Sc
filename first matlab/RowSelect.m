function [y , permut] = RowSelect(pr,key)
% allocate
y = 0 ;
%% turn keys and row tags on
% turn keys on
KeyVisible(key.tag,1);
% Row tags
tag = unique(key.tag_st_r,'rows');
n_row = size(tag,1) ;
% making stimulation keys visible
KeyVisible(tag,1);
% start Gtec
if pr.SimFlag == 0 && strcmp(pr.mod_O,'Online')
    set_param('EEG_Record','SimulationCommand','Start');
end

pause(pr.waits/1000);

%% stimulate
switch pr.mod_sig
    case 'SSMVEP'
    case 'SSVEP'
    case 'P300'
        %generate random permutation
        
        permut = randperm(n_row) ;
        for i = 1:pr.n_rep-1
            permut = cat(2,permut,randperm(n_row)) ;
            while permut(i*n_row) == permut(i*n_row+1)
                permut = cat(2,permut(1:i*n_row),randperm(n_row)) ;
            end
        end
        
        
        %Showing stimulus
address = Stimulus(pr.SimFlag,pr.mod_sig,tag,permut,pr.dur_st,pr.dur_ISI,pr.imgs,pr.mod_O,pr.path) ;        %        y = MyMethode(signal,permut) ;
if strcmp(pr.mod_O , 'Online')
    permut = permut -1;
    y = GetResp(pr.SerialPort,address);
    y = y-1 ;

end
        
        %% making stimulation keys invisible
        pause(pr.waits/2000);
        KeyVisible(tag,0);
        

        
        
        
end
end