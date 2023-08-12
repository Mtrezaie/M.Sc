function y = ErrEvaluator(net,data,classifier,varargin)
if nargin>4
    Model = varargin{2}  ;
    feat_layer = varargin{1} ;
end
switch classifier
    case 'SVM'
        [a,s] = predict(net, data' );
    case 'CNN'
        [a,s] = classify(net,table(data));
    case 'CNN activation'
        act = activations(net,table(data),feat_layer);
        s = reshape(act,2,1)' ;
    case 'CNN+SVM'
        act = activations(net,table(data),feat_layer);
        N = ndims(act) ;
        feat_svm = reshape(act,[],size(act,N)) ;
        [a,s] = predict(Model, feat_svm') ;
end
y = a ;
end