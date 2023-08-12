function [feat_test,feat_train,Test_mask] = TestTrainSeparator(data,sig,R_test)

switch sig
    case 'Errp'
        % load and balance
        x = data(2:end,8) ;
        y = cell2mat(data(2:end,4)) ;
%         % 0 to -1
%         y(y==0) = -1 ;
        [x, y] = DataSetBalance2(x,y) ;
        % indx for seperation
        L = length(y) ;
        indx1 = randperm(L/2,floor(R_test*L/2)) ;
        indx2 = indx1 + L/2 ;
        indx = [indx1,indx2] ;
        indx_test = zeros(1,L) ;
        for i = 1:length(indx)
            indx_test(indx(i)) = 1 ;
        end
        indx_train =  ~indx_test ;

        X_test = x(logical(indx_test)) ;
        Y_test = y(logical(indx_test)) ;
        % table
        feat_test = table(X_test,categorical(Y_test));

        X_train = x(logical(indx_train)) ;
        Y_train = y(logical(indx_train)) ;
        % table
        feat_train = table(X_train,categorical(Y_train));

        % useless
        Test_mask = 'useless';

    case 'P300'
        % test seperation
        L = length(data)-1 ;
        Test_indx = randperm(L,floor(L*R_test)) ;
        Test_mask = zeros(1,L) ;
        for i = 1:length(Test_indx)
            Test_mask(Test_indx(i)) = 1 ;
        end
 
        Train_mask = ~Test_mask ;
        Train_indx = find(Train_mask==1) ;

        d_test = data([1,Test_indx+1],[2,3,5,6,7]);
        d_train = data([1,Train_indx+1],[2,3,5,6,7]);

        [x_test,y_test] = TrialExtract(d_test) ;
        [x_train,y_train] = TrialExtract(d_train) ;

         % table
        feat_test = table(x_test,categorical(y_test));
        feat_train = table(x_train,categorical(y_train));


end

end