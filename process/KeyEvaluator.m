function [key_acc,labels_scores] = KeyEvaluator(net,data,needed_rep,classifier,varargin)
if nargin>4
   Model = varargin{2}  ;
   feat_layer = varargin{1} ;
end
%% pre allocation
labels_scores = cell(size(data,1),2) ;

labels_scores{1,1} = 'labels' ;
labels_scores{1,2} = 'Scores' ;

label = cell(needed_rep,1);
Scores = cell(needed_rep,1);
key_acc = zeros(needed_rep,1) ;

%% Score calculation
for i = 2:size(data,1)
    n_key = length(data{i,5}) ;
    % pre alocate
    for rep = 1:needed_rep
        switch classifier
            case 'SVM'
                [a,s] = predict(net, cell2mat(data{i,5+rep-1}') );
            case 'CNN'
                [a,s] = classify(net,table(data{i,5+rep-1}'));
            case 'CNN activation'
                act = activations(net,table(data{i,5+rep-1}'),feat_layer);
                s = reshape(act,2,n_key)' ;
            case 'CNN+SVM'
                act = activations(net,table(data{i,5+rep-1}'),feat_layer);
                N = ndims(act) ;
                feat_svm = reshape(act,[],size(act,N)) ;
                [a,s] = predict(Model, feat_svm') ;      
        end
        [~,sort_indx] = sort( data{i,2}( (rep-1)*n_key+1 : (rep)*n_key ) );
%         a(sort_indx,:) 
        Scores{rep} = s(sort_indx,:) ;

    end
    % save
     labels_scores{i,2} = Scores;
end
%% key predictions
% pre allocation
for i = 2:size(data,1)
    for rep = 1:needed_rep
    % finding
    Scores = labels_scores{i,2} ;
    indx = ScoreChoose(Scores(1:rep),'mean') ;
    

    if indx == data{i,3}
        key_acc(rep) = key_acc(rep)+1 ;
        label{rep} = 'true' ;
    else
        label{rep} = 'false' ;
    end
    end
    labels_scores{i,1} = label ;
end

key_acc = key_acc/(length(data)-1) ;


end