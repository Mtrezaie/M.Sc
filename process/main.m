clear ;
close all ;
clc ;
%% loading 3 runs for train and 1 for test
[path,~,~] = fileparts(which(mfilename));
files = dir([path,'\data\n*']);
L = length(files) ;
% information
PreP300Dur = +0.1;
PostP300Dur = 0.7;
PreErrDur = 0.1 ;
PostErrDur = 1.5 ;
LP = 0.1 ;
HP = 30 ;
Features = 'CNN3D real';
classifier =  'CNN'; % 'CNN' 'SVM' 'CNN+SVM' 'act'
signal = 'Errp'; %'P300' % 'Errp' 
network = 'the winner' ;
n_layer = 17;
batch = 128 ;
epoch = 100 ;
test_indx = 3;
train_indx = [1,2] ;
% train
data_train = cell(1,8);
for i = train_indx
    D = load([files(i).folder,'\',files(i).name]) ;
    D = DataExtractor(D,PreErrDur,PostErrDur,PreP300Dur,PostP300Dur,LP,HP);
    if i == 1
        data_train = D ;
    else
        data_train = cat(1,data_train,D(2:end,:));
    end
end
% visualization
feat_raw = TestTrainDataExtract('Test',signal,data_train) ;  
% train
feat_train = TestTrainDataExtract('Train',signal,data_train) ;
feat_train = DataTransform(feat_train,Features) ;
% test
D = load([files(test_indx).folder,'\',files(test_indx).name]) ;
data_test = DataExtractor(D,PreErrDur,PostErrDur,PreP300Dur,PostP300Dur,LP,HP);
data_test = DataTransform(data_test,Features) ;
feat_test = TestTrainDataExtract('Test',signal,data_test) ;

% network training
switch classifier
   
    case 'SVM'
        % SVM
        Model = fitcsvm(cell2mat(feat_train{:,1}),feat_train{:,2}... %);
             ,'Standardize',true,'KernelFunction','rbf','BoxConstraint',5, 'KernelScale',20);
        [out,s] = predict(Model, cell2mat(feat_test{:,1}) );
        acc_p300 = sum(out==feat_test{:,2})/length(out);
        if strcmp(signal,'P300')
        [key_acc,labels_scores] = KeyEvaluator(Model,data_test,3,classifier) ;
        end
    case 'CNN'
        %% net CNN
        [layers , options] = NetGenerator(network,size(cell2mat(feat_train{1,1})),'training-progress',batch,epoch,feat_test) ;
        net = trainNetwork(feat_train,layers,options);
        % evaluate
        [out,Scores] = classify(net,feat_test);
        acc_p300 = sum(out==feat_test{:,2})/length(out);
        if strcmp(signal,'P300')
        [key_acc,labels_scores] = KeyEvaluator(net,data_test,3,classifier) ;
        end

%         analyzeNetwork(net);     
    case 'act'
        %% net CNN
        [layers , options] = NetGenerator(network,size(cell2mat(feat_train{1,1})),'training-progress',batch,epoch,feat_test) ;
        net = trainNetwork(feat_train,layers,options);
        % evaluate
        [out,Scores] = classify(net,feat_test);
        acc_p300 = sum(out==feat_test{:,2})/length(out);
        [key_acc,labels_scores] = KeyEvaluator(net,data_test,3,'CNN activation','fc_2',nan) ;
%         analyzeNetwork(net);
 case 'CNN+SVM'

        Layers = net.Layers ;
        feat_layer = Layers(n_layer).Name ;
        
        %% net CNN
        [layers , options] = NetGenerator(network,size(cell2mat(feat_train{1,1})),'training-progress',batch,epoch,feat_test) ;
        net = trainNetwork(feat_train,layers,options);
        act = activations(net,feat_train(:,1),feat_layer);
        N = ndims(act) ;
        feat_svm = reshape(act,[],size(act,N));
        Model = fitcsvm(feat_svm',feat_train{:,2});
      
        % evaluate
        act = activations(net,feat_test(:,1),feat_layer);
        feat_svm = reshape(act,[],size(act,N));
        [out,s] = predict(Model, feat_svm' );
        acc_p300 = sum(out==feat_test{:,2})/length(out);
        [key_acc,labels_scores] = KeyEvaluator(net,data_test,3,'CNN+SVM',feat_layer,Model) ;
end
sum(double(out)==1) 
DataVisualizer('tsne 3d',net,feat_raw,Features,17) ;
% analyzeNetwork(net);