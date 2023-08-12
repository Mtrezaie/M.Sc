function DataVisualizer(mod,net,feat_raw,Features,n_layer)
%% choosing feature layer
Layers = net.Layers ;
feat_layer = Layers(n_layer).Name ;
%% data extraxtion and processing
n_data = size(feat_raw,1) ;
y = feat_raw{:,2} ;
% raw
X_raw = feat_raw{:,1} ;
S = size(X_raw{1}) ;
sig_raw = nan(n_data,S(1)*S(2));
for i = 1:n_data
    sig_raw(i,:) = reshape(X_raw{i},[],1) ;
end
% cooked
feat_cooked = DataTransform(feat_raw,Features) ;
X_cooked = feat_cooked{:,1} ;
act  = activations(net,feat_cooked(:,1),feat_layer);
sig_cooked = reshape(act,[],n_data)' ;

switch mod
    case 'tsne'
        %% tsne visualization
        % raw
        v_raw = tsne(sig_raw) ;
        % cooked
        v_cooked = tsne(sig_cooked) ;
        % % data selection
        % indx = randi(2,n_data,1)-1
        % plotting
        figure('name','Data visualization') ;
        subplot (1,2,1) ;
        gscatter(v_raw(:,1),v_raw(:,2),y,['b';'r']);
        title('raw data') ;
        legend('class1','class2');
        subplot (1,2,2) ;
        gscatter(v_cooked(:,1),v_cooked(:,2),y,['b';'r']);
        title('cooked data') ;
        legend('class1','class2');
    case 'pca'
        w = pca(sig_raw,'NumComponents',2);
        v_raw = sig_raw*w ;
        w = pca(sig_cooked,'NumComponents',2);
        v_cooked = sig_cooked*w ;
        % plotting
        figure('name','Data visualization') ;
        subplot (1,2,1) ;
        gscatter(v_raw(:,1),v_raw(:,2),y,['b';'r']);
        title('raw data') ;
        legend('class1','class2');
        subplot (1,2,2) ;
        gscatter(v_cooked(:,1),v_cooked(:,2),y,['b';'r']);
        title('cooked data') ;
        legend('class1','class2');

    case 'tsne 3d'
        %% tsne visualization
        % raw
        v_raw = tsne(sig_raw,'NumDimensions',3) ;
        % cooked
        v_cooked = tsne(sig_cooked,'NumDimensions',3) ;
        % % data selection
        % indx = randi(2,n_data,1)-1
        % plotting
        y = double(y) ;
        C = zeros(n_data,3);
        for i = 1:n_data
            if y(i) == 1
                C(i,:) = [1,0,0];
            else
                C(i,:) = [0,1,0];
            end
        end
            figure('name','Data visualization') ;
            subplot (1,2,1) ;
            scatter3(v_raw(:,1),v_raw(:,2),v_raw(:,3),15,C,'filled');
            title('raw data') ;
            legend('class1','class2');
            subplot (1,2,2) ;
            scatter3(v_cooked(:,1),v_cooked(:,2),v_cooked(:,3),15,C,'filled');
            title('cooked data') ;
            legend('class1','class2');
        end





end