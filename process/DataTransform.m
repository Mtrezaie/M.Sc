function data = DataTransform(data,mod)
% this function transform data into desired data

if istable(data)
    for i = 1:size(data,1)
        data{i,1} = { FeatExtract(cell2mat(data{i,1}),mod) } ;
    end

else
    for i = 2:length(data)
        data{i,8} = FeatExtract(data{i,8},mod) ; % Errors
        for j = 1:length(data{i,5})
            data{i,5}{j} =  FeatExtract(data{i,5}{j},mod) ; %rep1
            data{i,6}{j} =  FeatExtract(data{i,6}{j},mod) ; %rep2
            data{i,7}{j} =  FeatExtract(data{i,7}{j},mod) ; %rep3
        end
    end
end
end




