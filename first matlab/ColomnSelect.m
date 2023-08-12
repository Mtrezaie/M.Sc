function [y, permut] = ColomnSelect(pr,key,r)
% allocate
y = 0 ;
% turn every thing off except that row
% off
KeyVisible(key.tag,0);
% on
tag = [key.tag(key.row==r,:)] ;
KeyVisible(tag,1);
%% turn keys and row tags on
% colomn tags
indx =  find(key.row == r);
% including turn on off button
if strcmp(pr.mod_O , 'Online')
    indx = cat(1,(length(key.num)),indx) ;
end
% tags
tag_st = key.tag_st_cl(indx,:);
tag_key = key.tag(indx,:);
n_col = length(tag_st) ;
% turn that row and st buttons on
KeyVisible([tag_key;tag_st],1);
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
        
        permut = randperm(n_col) ;
        for i = 1:pr.n_rep-1
            permut = cat(2,permut,randperm(n_col)) ;
            while permut(i*n_col) == permut(i*n_col+1)
                permut = cat(2,permut(1:i*n_col),randperm(n_col)) ;
            end
        end
        
        %Showing stimulus
        address = Stimulus(pr.SimFlag,pr.mod_sig,tag_st,permut,pr.dur_st,pr.dur_ISI,pr.imgs,pr.mod_O,pr.path) ;
        if strcmp(pr.mod_O , 'Online')
             permut = permut -1;
             y = GetResp(pr.SerialPort,address);
             y = y-1;
        end

        %% making stimulation keys invisible
        pause(pr.waits/2000);
        KeyVisible(tag_st,0);

end
end