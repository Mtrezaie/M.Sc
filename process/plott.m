% plott(feat_train,11,'feat') ;
% plott(feat_test,11,'table') ;
function plott(feat,ch,mod)
switch mod
    case 'feat'
signal = feat{:,1} ;
label = double(feat{:,2}) ;
target = signal(label==2) ;
non_target = signal(label==1) ;
L1 = size(target,1) ;
L2 = size(non_target,1) ;
% mean
sum_target = 0 ;
sum_non_target = 0 ;
for i = 1:L1
    sum_target = sum_target + target{i} ;
end
for i = 1:L2
    sum_non_target = sum_non_target + non_target{i} ;
end

mean_target = sum_target/L1 ;
mean_non_target = sum_non_target/L2 ;
for ch = ch
    figure;
plot(squeeze(mean_target(:,ch)),'r') ;
hold on ;
plot(squeeze(mean_non_target(:,ch)),'b') ;
end
    case 'table'
        n_key = 6 ;
        data = feat ;
        target = zeros(size(data{2,5}{1})) ;
        non_target = zeros(size(data{2,5}{1})) ;
        n_target = 0;
        n_non_target = 0;


        n_rep = size(data,2)-4 ;
        for i = 2:size(data,1)
            for j = 5:n_rep+4
                permut = data{i,2}( (n_key*(j-5))+1 :  (n_key*(j-4))) ;
                for k = 1:n_key
                    if permut(k) == data{i,3}
                        target = target+data{i,j}{k} ;
                        n_target = n_target+1 ;
                    else
                        non_target = non_target+data{i,j}{k} ;
                        n_non_target = n_non_target+1 ;
                    end
                end
            end
        end
        target = target/n_target ;
        non_target = non_target/n_non_target ;


for ch = ch
    figure;
plot(squeeze(target(:,ch)),'r') ;
hold on ;
plot(squeeze(non_target(:,ch)),'b') ;
end



end
%
