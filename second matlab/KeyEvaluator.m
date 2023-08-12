function y = KeyEvaluator(net,data,needed_rep,classifier,varargin)
if nargin>4
    Model = varargin{2}  ;
    feat_layer = varargin{1} ;
end
%% pre allocation
Scores = cell(needed_rep,1);
%% Score calculation
n_key = length(data{2,1}) ;
% pre alocate
for rep = 1:needed_rep
    switch classifier
        case 'SVM'
            [a,s] = predict(net, cell2mat(data{2,rep}') );
        case 'CNN'
            [a,s] = classify(net,table(data{2,rep}'));
        case 'CNN activation'
            act = activations(net,table(data{2,rep}'),feat_layer);
            s = reshape(act,2,n_key)' ;
        case 'CNN+SVM'
            act = activations(net,table(data{2,rep}'),feat_layer);
            N = ndims(act) ;
            feat_svm = reshape(act,[],size(act,N)) ;
            [a,s] = predict(Model, feat_svm') ;
    end
    [~,sort_indx] = sort( data{2,4}( (rep-1)*n_key+1 : (rep)*n_key ) );
    %         a(sort_indx,:)
    Scores{rep} = s(sort_indx,:) ;

end

%% key prediction
y = ScoreChoose(Scores(1:needed_rep),'mean') ;

end