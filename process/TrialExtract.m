function [x,y] = TrialExtract(data)

L = length(data) ;
x = {} ;
y = [] ;

for i = 2:L
    s = length(data{i,3});
    for j = 1:s
        x = cat(1,x,data{i,3}(j)) ; 
        if data{i,1}(j) == data{i,2}
            y = cat(1,y,1) ; %target
        else
            y = cat(1,y,-1) ; % non Traget
        end

        x = cat(1,x,data{i,4}(j)) ;
        if data{i,1}(j+s) == data{i,2}
            y = cat(1,y,1) ; %target
             else
            y = cat(1,y,-1) ; % non Traget
        end

         x = cat(1,x,data{i,5}(j)) ;
        if data{i,1}(j+(2*s)) == data{i,2}
            y = cat(1,y,1) ; %target
             else
            y = cat(1,y,-1) ; % non Traget
        end
    end
end


end