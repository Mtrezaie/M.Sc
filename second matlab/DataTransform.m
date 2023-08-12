function data = DataTransform(data,mod)

if iscell(data)
    
    n_rep = 3 ;
    n_key = length(data{2,4})/n_rep ;
    for i = 1:n_rep
        for j = 1:n_key
            data{2,i}{j} = FeatExtract(data{2,i}{j},mod);
        end
    end

else
    data = FeatExtract(data) ;
end


end