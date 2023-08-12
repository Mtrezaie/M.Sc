function feat = TestTrainDataExtract(mod,sig,data)

switch sig
    case 'Errp'
        % load and balance
        x = data(2:end,8) ;
        y = cell2mat(data(2:end,4)) ;
        % 0 to -1
        y(y==0) = -1 ;

    case 'P300'
        d = data(:,[2,3,5,6,7]);
        [x,y] = TrialExtract(d) ;

end

% balancing
switch mod
    case 'Train'

        [x,y] = DataSetBalance(x,y,'repeat');

    case 'Test'
        

end
% table
feat = table(x,categorical(y));


end